Return-Path: <linux-kernel+bounces-529622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F260DA428EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B26517B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65645265CA6;
	Mon, 24 Feb 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTTQ01OC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4B265619
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416274; cv=none; b=k/4Q86QzB30mXUEsB7YaaPWKn0h6UTU85FGKwehWnV600Tpi9rn2UIK9Tsr99NYCvTuGsuZC4QBtXckfizINx7e5eVCypWBJle7rJeNhnjoGIlfSnCiNmWz4ePwunHsUwKqjsCRDueBs3jQBOe0rpTDYHwyLWnkB0fRWjYNrm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416274; c=relaxed/simple;
	bh=PbfsQL2sPiow+PCIjz3+Rkn8IIDh6NjOMMFOaOgAruU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Cz7bbUN1L+f69bA4tcexgIEcEcEHtmEjSI8+X2DoGNMpdHXHhW4MXWAMitdvFTH7/1l8DB+ycvwaUwYdMJ6cyELd2/vi4AJFBJnxVmvUfrBOQE4HQANJfNpV5vuzAlu8NWK/+oEc7YNTfORTfVYFvwfbRDLIISaE3QkPfOFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTTQ01OC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Biw2WTLSjf4saKl00azgbJFpGTFLYZbTKqchEcn3wv8=;
	b=PTTQ01OCDDlhu7E6wpvq2/q3PgYy+okyGhSej7KToLA2o5SiNX8lI7PKOI5SX5MqFq6cWN
	s/M7w0plZElQ+XS0Z18stXT0NZRyTaQMC7i3fU3AsCXTQ6t6xi5dpWzfFcxfXbvvkijHr4
	niXKBVELf+p7xK6VCIhpPZy4/2uQxQw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-cwlvTk3KPAm1Q98sYFFJ9A-1; Mon, 24 Feb 2025 11:57:51 -0500
X-MC-Unique: cwlvTk3KPAm1Q98sYFFJ9A-1
X-Mimecast-MFC-AGG-ID: cwlvTk3KPAm1Q98sYFFJ9A_1740416270
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f455a8e43so1778894f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416270; x=1741021070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Biw2WTLSjf4saKl00azgbJFpGTFLYZbTKqchEcn3wv8=;
        b=HqlfWGElXUWW9oSsY22wwLva5vo81fUHwcQNWYM6JEi6xhAsBUipRqW9qJfIslZEeC
         zhHdPQL5qfPVCwbBhWQ7N58Y6V5Xigv1TD5b4v8PZ2FCp77RDth1+H91l23OdfR3j5Pn
         bmMLkzIsMviDYjC8jBhPcSTlNleKOWIfW9UrTrVk24RQzKkx3BWtXnyuZwFtqagzQhuZ
         Kf67BpLtVdFVVEqkWJ6yQsjwihrXXzwaKYZMUbo0e7ID8kYYdHGX0jwqop0+8GvO6oJU
         /kM1/buqLJuyIkGvTN1AjG2szpWoXNpX5q6Dyl0bLK2yk+KbZ65K5O6fJ0ua5r2A5DgG
         r1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW6szqvleWCHmDpli5UaqAAO+El9ibxFoaMO+paJSJ0johwhkAdo9kr+IUwckWnTKA1H/ViAUzVr+k+Oro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EbH2OVVaaPWiJUeOT836NrT8AuzZzZYiyQE2vNyGss8x47rR
	yg6XL0yllbZLscjE7aU6QcFQp5Mpanvl1yu+Pg/7naIZL+SA5v+ZN8KgaNJIWzxDPbdrop5iduN
	NTMKvbAZ2SDZJ1aMltt5PkbXj3dby9esVhcORphVVKQHULU03AbbYtCo8/FFe81GYMh2y/JkznZ
	suIgLLkeJ/5wQVcXLupyJCPwq7suvX3Q1mITES
X-Gm-Gg: ASbGncsXB2kdaBViwL/Dxgcs0VJdZc+T7CVVN6gb1sd8znFKXtK2LC0QMzM/yaF1v8P
	6mlOhDps2ca1r/w3mJSgj5ZYJTk0yLfXFpHEGu1ewCaQqMuTYEypRCH/moja5lpNkET+I54+uvg
	==
X-Received: by 2002:a5d:5350:0:b0:38f:2a84:7542 with SMTP id ffacd0b85a97d-38f6e97af1emr9718371f8f.28.1740416269852;
        Mon, 24 Feb 2025 08:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5dNRxtSyZLnAiRMZfJOPsJBulsojl4I5P8fndIcW5Ryl+25L4glEbkJHy6mYbN+5z31Sip8Eedjc7ZaCr0pE=
X-Received: by 2002:a5d:5350:0:b0:38f:2a84:7542 with SMTP id
 ffacd0b85a97d-38f6e97af1emr9718359f8f.28.1740416269554; Mon, 24 Feb 2025
 08:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222014232.2301713-1-seanjc@google.com>
In-Reply-To: <20250222014232.2301713-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Feb 2025 17:57:38 +0100
X-Gm-Features: AWEUYZkqvFCDavxVA4pRYu9m38ZLfRG6NWtlLzkMwKjWG0F_dMA0RYDZW7PpZ40
Message-ID: <CABgObfaUkZxE7g8Qic3oMzHVu1PozT=XixnfNxXLrVdq_wXRww@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: Fixes, new tests, and more!
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 2:42=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a pile of long-overdue changes.  Note, a few of the new tests
> fail on AMD CPUs (LAM and  bus lock #DB).  I was hoping to get the KVM
> fixes posted today, but I kept running into KUT failures (there's still
> one more failure with apic-split when running on Turin with AVIC enabled,
> but that one is pre-existing).
>
> If someone wants a project, SEV-ES, SEV-SNP, and TDX support is still
> awaiting review+merge.
>
> The following changes since commit f77fb696cfd0e4a5562cdca189be557946bf52=
2f:
>
>   arm: pmu: Actually use counter 0 in test_event_counter_config() (2025-0=
2-04 14:09:20 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2025.02.21
>
> for you to fetch changes up to 8d9218bb6b7ced9e8244250b8f0d8b2090c1042a:
>
>   x86/debug: Add a split-lock #AC / bus-lock #DB testcase (2025-02-21 17:=
11:29 -0800)

Pulled, thanks.

Paolo


