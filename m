Return-Path: <linux-kernel+bounces-209663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA190390F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2801F2248E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6F178385;
	Tue, 11 Jun 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJfaEyfs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520E176AD4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102327; cv=none; b=oqqP3l2INUeo3MRcfhYOMlOlJuagyN1T2yJErlyVGNG2G9C4W+wc3I+A7OYfqh094nhf0oI0RZyLQQSg1G2NHvPjNYxR8VX/K4rcOUSO/MSD9/5qN6Qoz2BtNB8TlikmQTVvx6PgQ/iOpFkR0KOc9WE4E/jPZXdxWlIFCts2q+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102327; c=relaxed/simple;
	bh=LpVxpVVK9dZ9VsGBtZI3gqo7kMi2srf+dwknjVIo3Ek=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mcwreJOP+OXnQ5jjk4uFriD7fbizQc0BUwflI39Z290CCQzEnDBy2KlJBe+DlPvAibO6dunYpf99zoy7SqUrLLnKdidnhzDvFfedQALG5T9g/9wnqXvE5SMcOc37odidzx2OqC7Jq23or1q8MNzA8KD9EbYZs3l8hbolsHIN/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJfaEyfs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718102325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpVxpVVK9dZ9VsGBtZI3gqo7kMi2srf+dwknjVIo3Ek=;
	b=YJfaEyfsXBE4J4bvJeCJn5iOJtYwaJ13naOnln5JcrhWfvBDZ7LGlFugzVOpnM89+mJr0L
	6uuOI676RdbmXlA1h6z+OJaGm2GdJS+GUEF/PDYNGqyBSq8uOdUf+z9PeJUIxo+UMdjFzI
	iI8AsoRdhBFjgk2aEnYPIQF1Bf4oMn0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-T-JetmPGMtShwvrWWaEAUw-1; Tue, 11 Jun 2024 06:38:44 -0400
X-MC-Unique: T-JetmPGMtShwvrWWaEAUw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-795cce8b773so106553885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102324; x=1718707124;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpVxpVVK9dZ9VsGBtZI3gqo7kMi2srf+dwknjVIo3Ek=;
        b=b/UNyOfzQ0mXLHRS5S+u+PCKrQAvPmsC6b3xrogaqPhWNsX7No7t/isN7XHSw5Tuqj
         4m2cMXYdhf6buMSN2dRZ7n7dgflQ7qrCkBSgfieqxNi2p5ngeAugeLd6sfR9ofdpUpKo
         GlTJSUPI6u2PMu/eaQHfMAa2WqXO10Lf6BR+Db0cHEkYcqHEnsEXcw/9bIwRY+Zy3Peg
         AlaiG8pZlwm5BBj8PNoyh8oeGjYCvQIhZUWBfqnO5HmEdSYRQCRx0nniuahd3UyS6xZl
         Y3w+EHx2AwuOmKSyZEpCRTdrUdlYqVy2KgM+iCjsenSNCqU9nw8ou2+vMksrsKylXGnM
         n83Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4AfigfRGiwfjNOqTq1EXC0aYMyKLtNhFQaHuFY35q35nWcGPRCqgFYQr5zlDoUGQlvYW/OME4fxy6ZYoyXKsD/co1Sm8DzGn9Y5C
X-Gm-Message-State: AOJu0Yzsr1rqb2ZkXbVU6nCfc30rNsn+oyQKm1o9d/21cbPDL8PgvTpo
	LqIMSavoVOl4iWUmhoHzD1neUs3vnP+hnW6YcUZJ1c2vF/gg+Uw8yVahmez2tOkEXsGW+3bVOmY
	dzrXnZrxDSsopyvLSBZzXrkP+1I6eQCgd/f4Sp7pXR1e7DYRU5lC2TRj5HXz+jQ==
X-Received: by 2002:a05:620a:3951:b0:795:4c65:fe39 with SMTP id af79cd13be357-7954c660a0amr1230871185a.58.1718102323520;
        Tue, 11 Jun 2024 03:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWH8vSQU7iczW/0/WLKHfejbsoDwghIq9TNpqFLbKxfZBhFgK72IviX2gClBpKbMjxLDGMkA==
X-Received: by 2002:a05:620a:3951:b0:795:4c65:fe39 with SMTP id af79cd13be357-7954c660a0amr1230867885a.58.1718102322807;
        Tue, 11 Jun 2024 03:38:42 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4405daf10a4sm27135961cf.13.2024.06.11.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:38:42 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:38:37 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org
cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 0/6] KVM: arm64: emulation for CTR_EL0
In-Reply-To: <20240603130507.17597-1-sebott@redhat.com>
Message-ID: <693a8742-c40c-dcb1-6b4a-43798959b10a@redhat.com>
References: <20240603130507.17597-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hi Marc, Oliver

anything else I should change here?

Sebastian


