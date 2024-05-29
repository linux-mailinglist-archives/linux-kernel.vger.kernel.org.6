Return-Path: <linux-kernel+bounces-194364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FC8D3AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40A41C2329D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F9180A92;
	Wed, 29 May 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW1xDfWA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893F18130D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996567; cv=none; b=DwyEoPzCqo1cKq+K+lAhep3pbInDX/pfXBAN0144EyZahdyVRUocGT5Nr0iFM2MIlxkC/zw/0WM+ZPKEyAjn/vwUbxh6aVGwsX2Lv6LZK288lX4jYsCJZxqhgZTf/B6pa2Eww/HoYBC+Ic3yS7PRL9XJpyT8K4hmjRQUiiG8PWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996567; c=relaxed/simple;
	bh=5EAuE4m6aZKJdT/S8iDYy5RWTfH+qE69UIxaK12MGSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u1t2BiQqLcT3RVzZG2dcJNbFae0MRLHNFUTDaT8dLjAK8e7oHck9sF9QXbC+Ss2ouq5kR02+KZnwNu+gsFshmsthr8MIl59PmGp0S0b99okEHPAI80EDoTfFjbL+Aismm4axz8Z9k6AabQwYegWu3g6NF9tVcMz/rGnHttwem1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iW1xDfWA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716996565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EAuE4m6aZKJdT/S8iDYy5RWTfH+qE69UIxaK12MGSw=;
	b=iW1xDfWAiHS+heEzglVEx6scnFHuF7YFoY3xuY7u5CFAVY5l4F7K8SMdnZRsOKhjl53C8X
	Mai3H3oWygv5dcQehXR7vqIA6xIOGvAyL0Sm6gwitSDMkQmLimUDfCDV7Aa7Ovt+du3eIu
	1GDC5NSIYqAYZXLv7wYB20tB/kYEC2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-OFBPZySWOyiDg9gRj7uM8g-1; Wed, 29 May 2024 11:29:22 -0400
X-MC-Unique: OFBPZySWOyiDg9gRj7uM8g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354fb2cf5b0so1873798f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996561; x=1717601361;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EAuE4m6aZKJdT/S8iDYy5RWTfH+qE69UIxaK12MGSw=;
        b=tIWNU1sSzlqZAUpNasssagias6SWYQ1vSWu6qqzAzV/qoqvzYwIdElpYnSCUx3sC/P
         qz+Gu1R5L5al8cjZ3KRyQjialSWtaIimwIegewPxkHruxIyQaqql3Pk4gCoGWazQ/Ai+
         RK9MM++6soWucFrtOPoTTr1g9ur6QmMQwpMpbpanJo8NVQfHnuBE4G4lS/UIva61RkzU
         yK2zwe8xjWseuSpAtoGUKhAwwjyr2K4ZxwrKFNopGWKwFZPQhS3d99tGMNAYOjxPxJE8
         d4++FicPaiGo+l1RU+N8+tc7uEXgpI1AmrLjM9Ldy9lELRvQsC+WPD0T/H1ITtMlwMci
         ks5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdeWBElKQiJktuypfxlA+GrM6C8nI0Q0SxW+fbuZrVVfGvQxQBo8FECC4r3ZdDGV8+WFiyFS34sK+jNNG6XeTLUHqeBXqbHNJua0SK
X-Gm-Message-State: AOJu0YyJDKhTd0zX/rdp9PAPk8YD+IuVI/r+WuysBof+PpgxLBOFT/lR
	pffmuQOHO1Go6dayNnnPo1Umfwa3TUXbqszUHVGL2fNHPsglCsL3TFwN25sgGDCEG0vzqGqwiSq
	qYyLzMsayVKccAsr7SH8kiIAJzs3CnNbdB4biJ9XA5Pi5Dw47mC5GtkMfPIa4FA==
X-Received: by 2002:a5d:6991:0:b0:354:f286:4f0c with SMTP id ffacd0b85a97d-3552fe029a0mr12407202f8f.51.1716996561611;
        Wed, 29 May 2024 08:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRJjULm6jx6xOHCCpirutvbUnzT/a6jQusAfJO3XKjkkjlSGtoHgavcGj/S/fqDOvU0+uebQ==
X-Received: by 2002:a5d:6991:0:b0:354:f286:4f0c with SMTP id ffacd0b85a97d-3552fe029a0mr12407190f8f.51.1716996561221;
        Wed, 29 May 2024 08:29:21 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dd73sm15045365f8f.18.2024.05.29.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:29:20 -0700 (PDT)
Date: Wed, 29 May 2024 17:29:19 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/6] KVM: arm64: rename functions for invariant sys
 regs
In-Reply-To: <b045f810-eb79-4de6-b149-0d64834d53d4@redhat.com>
Message-ID: <5a00647d-7d33-81a6-c783-2212ff73ca8b@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com> <20240514072252.5657-6-sebott@redhat.com> <b045f810-eb79-4de6-b149-0d64834d53d4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hej Eric,

On Wed, 29 May 2024, Eric Auger wrote:
> On 5/14/24 09:22, Sebastian Ott wrote:
>> Invariant system id registers are populated with host values
>> at initialization time using their .reset function cb.
> get_##reg call read_sysreg(). I don't really understand the above
> sentence. Please could you elaborate?
>

struct sys_reg_desc has 2 function pointers (among others):
reset and .get_user . The functions implementing these are
usually named accordingly. For invariant registers only
reset is used but set to functions that are called get_*
(which is usually used to implement .get_user).

E.g.: invariant_sys_regs[0].reset == get_midr_el1

When trying to figure out this code I was confused by this, hence
this patch..

Sebastian


