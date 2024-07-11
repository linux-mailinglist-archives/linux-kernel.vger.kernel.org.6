Return-Path: <linux-kernel+bounces-249428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4892EB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F60A1F21E84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6FC16C437;
	Thu, 11 Jul 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvjjQqIM"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587E2F46
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711186; cv=none; b=LdoJAdag0+TiyPPFni03GRE34S2jhFWOw3ah0J1at5U7Q9PwbYwtZezTlogtJ1BKBX3wNxjRNx40XbciVWpibr318U38PSiikoOJzJPwyLHN4CWuLLm0Cu28JW0NQ0vLzKS2S9fEwSg+Kjg2EwGqytF5rgNOVhTG7qE7sO0pt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711186; c=relaxed/simple;
	bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmAyLA16T7Hnl0uVlIOssIRL4fsV1sMX7V+F44x+F+2FZi8shICou3Gj5uDoovx4b+TN80kaGBTqcTiQk9mSadSdNN/lXeovyBmwb7Cv1UVOHJrVl6TD4BHZIpspXoHSYOoCvksUzFMajR7v11j4GGX64bGQAy1374IVGWTg3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvjjQqIM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso17241a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720711183; x=1721315983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
        b=hvjjQqIM97atANHLuYnpBmgnOsg/biOrQ1LurrY+jpDWksUQUJIO1r9iquhz/oFtN9
         9IGnvcWIJ2pksP3eDd67yUaa5chlexaqpsK9/KRAaJBXldEJBhDNzegj64nwE8/NMxC3
         iPiRJEG0a+5mi2Ppn/DIkTvmeJ9mKtgUhmkSs6zb4nzM+WYB3CCkvvPPEw+0H3QhILV0
         CrJPpS8v8tIgyMpexkgd38CvoBCefT0eHEG3E4WQMKlAVm7fHW6zsiNSx16Yeax/3Zb0
         eF1w4jV20I0v2+W2eeWjO715VEukdG++klVdRrsuZ6Olk/dANMF+/1sdBvH8g5MTcYxb
         AorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720711183; x=1721315983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
        b=hUqjyESgT2CtZCElx0eTrGIpKHeJZJxsQTQk9HO0Ptcu3WuytdfNN6Pc5ILW248Cch
         ZXVKS/+SPRFEPTCUT2UScihv5kys7jhyGtXyfWlORdIIsfnLDS6dZtVJW4+flPzVRKXS
         TiuBw+bCcF+vU2twl+hJ66zw/NxCxRfMAy40l5WsJDyYrQHKr9FW+6sc3cqYJWHg6pEk
         RdnMzwqL/5jH+HgQUr5yZ//TuZBJv7nHTetmUaoWQGw3u44MIiZdPjG0iln4RymYO/jt
         JmMAIzpnqiK+RaE5diYjO2GemOG/MrsCvkj1n6DiamPWcn9EwhQHH3xr5SKemRw+5mIk
         XNog==
X-Forwarded-Encrypted: i=1; AJvYcCWqGqtPzh6v5xeL3sIegFcNzqs85ErmE7Ivy9OzU8ndb0akyks9NFXmZCtXDm/Dh2KzwgvBMuOfvQC8KsKsGIVbSXyXv7JyjkZEsOyl
X-Gm-Message-State: AOJu0YzCrwn61m4Mz0q6VgtyrU4hY2DI7qDVpZJl81IxBaW7BlffXsUz
	asC2Qnm3e3Px5zPOsOhLf81O8djVcMVWT8GtiIj2c18MVRqcRhW9WOxhKtZGuienrVFm93ArFJ4
	Vfws5wMl09WdsnxPapCb8YNUqFezQhivi/SdC
X-Google-Smtp-Source: AGHT+IFUZHGB/MYTQ+AEtXTIG2MUpAJou7TV7BlhO3k/D26+Cr+yw9GU5imU9h/cKuxSPpspQWgJZ2uy19SIpgHSl2c=
X-Received: by 2002:a50:cd8c:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-5984e8f5e6fmr182082a12.5.1720711182527;
 Thu, 11 Jul 2024 08:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:19:30 -0600
Message-ID: <CAMkAt6qtViYTx_xfxt=4VQ6TQG=53X-ZdEZ84s8UrZm3p-4brA@mail.gmail.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> This commit separates the SEV, SEV-ES, SEV-SNP ioctl calls from its
> positive test asserts. This is done so that negative tests can be
> introduced and both kinds of testing can be performed independently
> using the same base helpers of the ioctl.
>
> This commit also adds additional parameters such as flags to improve
> testing coverage for the ioctls.
>
> Cleanups performed with no functional change intended.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

