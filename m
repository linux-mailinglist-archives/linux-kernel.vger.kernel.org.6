Return-Path: <linux-kernel+bounces-306296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B91963CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B545E281EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C2187FFF;
	Thu, 29 Aug 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jagqqj3F"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E84188CB1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916223; cv=none; b=VN7A6UPKU4bNSp+bBCd0d2KaKS9lUxEqO95PH7FEj5B576xdj3BvM0C6aHUpB1jOCEl9VFFjIXHfPZ1buo+Klxm/gF8qCQZpXuldDPoi/yuCvAlHcDpi9o/dmweSZJaZgTqnldx1J4R3h6sctm3rH6DQqQYziMOxKvzk5JeipyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916223; c=relaxed/simple;
	bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmDbqZ3QMQMvfDBiTRG7uw4LIzxYg2izWc3i5zosftC+etJu8RK51hpmHmcAx+TiVoJ4IyapH+b2JbZgNolfZ3R4S5hox08l8ZZx/SkLZhuwNfb5WAZbVJwup7IgPQfsE2RPr9PXWZmYKVc0wmulVzAcuM0cTypEELELv1h4PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jagqqj3F; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d0e7dfab60so4406817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724916221; x=1725521021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
        b=Jagqqj3FuOdSw9XtHbVg20SIDNMjY4ehwzeC8x02tDhAr82mWcVBeQYahs4rzT2cgj
         QhdRGRT3j1zx5ENPgwrCtMesiWhi3Zx6Wb5KpQx+tGNdDfkE6LerFZpLuIU/FJuu8T7h
         eWr/Ly/A50u9IoZ3XxfCqTBTK1vzWY+S3AK+hM22ozBhGqNmOWXnDLatacogWpgRsXjs
         8ZQCbW8eaEmbzkAmFkAOW+atXBD0g1NBmeKsQ+aSAmmOqJm3imYX7c1vWxw87Qp0uPau
         JGmE/cV+FMyP9q/k4GsEDjiaviGP9u73jSvDpLmRgJHFn9rajgOTHM86veoLHd44HOAO
         /IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724916221; x=1725521021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
        b=bUc1TfQUaoANHNXBt3btVZ0dhpE2mOccP5kVTG5U88V0MT8Mtr8fMue6IsaOVFEjDU
         D78zP3HS7EYbn3XixPRDZnOfL/E7WvEH9+ROV7Wf4Tt033oX+TbxMlinq0naW8fvrNmk
         0UcIRa5YFY/GEZuntB7IeicQWlm5vWynm54Dibc3be5BkcYqQcNY2xnv7RFdMwKKHnK0
         2uj/8gL78M1R2BTA2aa91pcjYdID6Ug6RMNcGMjB4te9OKWy7hTSnsocNPUyVcMi07yR
         0d8HJ6KiymDWb5eWWLiP4PxJ0zqoMVnTOtaLF24ZTkzDifWuwrpFWrArybc3KbrFyiD/
         V74g==
X-Forwarded-Encrypted: i=1; AJvYcCWqbcie51JuHQvetKRKDso6g33HgXrghA/IcwyXxHzb87w8MsWaFURzsaB/rkqjJl0ITpXog9TXRCuEqgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI90131w1wdpNYsGRel1RaRG0i8u9APAgCq7/rgBc1qAT5K88V
	4L6UnY9SFG6zGjj0tUMi0kvkPOx6TIJxn4LrYo2Smn1cja/yOiUx7IZbVBu31WabMnHKhVcHruT
	7silOuh3wWJguHcA3e3hmO1/WnrI=
X-Google-Smtp-Source: AGHT+IFNi7ECsQbvmIp/8PfQr/l55yP9JwlrflyjvYOYxQFMc+pqAgeOq024GeKshYzuoSfkpgWZTNj25IgSp1Z5FWs=
X-Received: by 2002:a05:690c:dd2:b0:64b:69f0:f8f2 with SMTP id
 00721157ae682-6d27595e9b7mr20236247b3.3.1724916220881; Thu, 29 Aug 2024
 00:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com> <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
In-Reply-To: <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:23:30 +0200
Message-ID: <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

While reading the diff of f90584f4beb84211c4d21b319cc13f391fe9f3c2 I
wonder if the following change is correct.

It is about iommu.c and the change to domain_context_clear_one function.

Previously you first store the domain_id to did_old and then you call
context_clear_entry.
After that you use iommu->flush.flush_context and provide the did_old,
so the value before clearing the entry.

Now, you call context_clear_entry and after that you call
intel_context_flush_present that contains the remaining part.
In intel_context_flush_present the domain_id will betaken (AFTER it
has been cleared) and call flush_context with it.

Is this done by intention or changed behaviour?

