Return-Path: <linux-kernel+bounces-278566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6394B1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1746F1F21089
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239C149E09;
	Wed,  7 Aug 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IX2FQYwA"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ADE1465BD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065349; cv=none; b=P+MYsLdKvHVCwr1+ZFeC3+gLWX0Ueg6C04Fvv1u5U0g4tqFRuXOVH5sxcAw3qkxemAVOUupzCFDfVcBTl3GVJdnoBoeN+kgYtaXb+K3txMhVYpJp4iuitS/t32n1c7HG9XVh/UWNaIZBEr21ewQM3OXwFl8zUnS0x1/A3KxfL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065349; c=relaxed/simple;
	bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2W95q6UQuHgHu5aTuiXCAMSOD1SjT5vQ5KaAUnmDmHoxYaPn0zzSuFzYIiGj/wAjZl0UNHN2Je/eiSSBNETPVVcoYmWiKl/Y8R+F7lt7XP0DdR9Bq6V/fDhokZDViGu+hFdagfzvvDLINNaj9E3+Usfdja8aUFC20jUzy/vDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IX2FQYwA; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260e1b5576aso238920fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723065347; x=1723670147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=IX2FQYwA4XecvFesD7yH3fT49SseorMcnezZ5VGSAuBwOS50psQM0zxkP2vIMKEPWa
         Igc7ew3byNckpzn/Jf8kaN+CbaHk5uisel8FyNZz7fXY2BXV3pWX8qpSJAFkT1A64AE5
         nUMrGZlvM67GLILHpHhjNqDZmVsK4yQcEpq3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065347; x=1723670147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=H1ZzdkCWsKI1vcUUYNFa0CjTRFSELe2OvOb+olHVcyUER0sACamXIgeX7XGUOAQ0NM
         F6yABzClkbOtUrOf3pz+Uq8qaH9JNwX3ryUohGddpOb2vBBime07xSTFicN6zUZh/anU
         uoJ+PHAemap3WVor0VbRCYvCLcVwNzJ7ajgEDqCSFMsPoOCyDCpAreDfj4jNpdRWeYdg
         ouLDRWDoJO0e/ociX+4ahzxYSAo/mxl7n4vR67/Aai5xAn/uwd+zRmZVYBYoWdOIYJA6
         LlDoihuVn9PHBifOTU1eGMvgvLpsosQXI/0+/UVBckzwEsz+LcyBp9uTRZdWgm/VbcCs
         qzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo9UU+NLqxvsE5s1ql3U5JM3an+S2vl4b6xuKu8FzyFsCbQAddrMuqfzu/rXNHNPwzbwTukwtgn0XM05I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6+QoQR4K70N+snDoSSW0+y2rhUCaRxADXkRjK8DKJ/85+laq
	TCWF+aUy0vFPes31HrICbO1N8O4EDGmt/S6HTq817GgYPvbMna3VFDMciG4qUad4ats5FHfcSv2
	BhuJoXOWcf9KF5QQLuPj/LKj0zd22dXGKwDvs
X-Google-Smtp-Source: AGHT+IFdG0BWwdv7/XaDKrxEwS0DUTDT/gdv5ciTviaWNvE2T0bsvZHSOHevFbbDDv67gzv6SOrrHeLTm/T79qtdatg=
X-Received: by 2002:a05:6871:3422:b0:261:13c6:e843 with SMTP id
 586e51a60fabf-26891d3ce49mr24267160fac.15.1723065347097; Wed, 07 Aug 2024
 14:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org> <20240807071740.GF1532424@black.fi.intel.com>
In-Reply-To: <20240807071740.GF1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 7 Aug 2024 17:15:36 -0400
Message-ID: <CA+Y6NJE0QB-W7hBOD_S1XwoSosg3Hh1FH0a8Um16g3Ex_1V9=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:17=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> I suggest opening the heuristic here a bit more.

Could you clarify what you mean by "opening the heuristic"?
What details should I remove?

And add the links to
> the Microsoft firmware document somewhere. These:
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-us=
b4-to-usb4-host-routers
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#identifying-externally-exposed-pcie-root-ports

Is it good enough to have them in the commit message? Or should they
be linked in probe.c?

