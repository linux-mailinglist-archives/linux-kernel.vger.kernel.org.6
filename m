Return-Path: <linux-kernel+bounces-177766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291838C4463
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DB7B21A70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9387153BEE;
	Mon, 13 May 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQyemtW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5C1F600
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614626; cv=none; b=D2AntbWKDiS1HS8UHHpbVbPwWRnKOgCy5n8xymlF+utt+nsscshdv/GAbAXpkkMGPnFsfp9qvmspNV6qS4vPfePRMWXQ60h3GgCeVwsyOaLNXdno14XRtt7NnkL0ULVZ6DL0USErhPfRyRSGLJxzMuPwXY5Xh9oZxwk1lgY/ZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614626; c=relaxed/simple;
	bh=7Gao0tGPrCT25V8Kaxx9hq8Ru2I69jSTMO59Zwlth4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxPTxsru4ZkndIZedsTH1/VNPLVLVh3bE8cxN8wELkTx+m4Hp0X134FMHREHtd/sNOdqALObAZjPczuFJNEiuVJkTRi1ADGKPKBVPedCXjahOg7c+LakXqwG4e6m9i6dGvS4vqKl3++JaeyInrEPaVNagk8ytJc+X70KziECa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQyemtW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so39236701fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614623; x=1716219423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gao0tGPrCT25V8Kaxx9hq8Ru2I69jSTMO59Zwlth4o=;
        b=NRQyemtWabgHokhJrcu2KRq5KBjo0zV78aZ4cOcR/qLlDRZHewgJxYzz1O0Hkw4co3
         67MFMJ18PL24wdxX6KeQEuqRUatvUKiTBW2sEvqWTkwCZxjd9z6FCLVXpIkImpBPtGOA
         a/VZD1iTIEPzDqSNeM8OqL87cn/KdKW4jHeB4Mmtv3nv3mrIb8jsZ4ejNCfhTrEdUHUf
         zJ1ejI+pOytNya7/dJJakL4uJz0ZYf8lD0kUmiZ7dIzFR4fO3jcYYfv9ayT6Vz6JFcqw
         +89fR1IB5AejDxdCuH/GF/X+bJUTlcadQO7IHlP8dVF8UH5HHLw/0C9t7Owh2QU2L19j
         j1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614623; x=1716219423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gao0tGPrCT25V8Kaxx9hq8Ru2I69jSTMO59Zwlth4o=;
        b=iHumInI3/EmG/B6g+Vkfnw//K4pIoVlKOgIaMSQ0EC4sHRSCpies0GmFv5yOB7QsLk
         OnzFSEhh5nlo+Bu47VFC6w4OODrVvpSDIbP/p9VWTPmmrjpnJzA18OVbTIxDLMS6R4Yl
         icj1pmAdMVsPnCMd6sanas9xf9/PZt29mj/Ok4auuatu6hruY67uLPEoGMdl9axK34Qt
         vZ35ZDqWKw9mxtQe5OoHfkWnOUGsT0Wn3Yw5yR4Sog9MXxcNM8M29JQju0It2mzL3cz9
         5N2cTu0A2/mUTBMji22MxYKJRjGFamNeMU1sySblImAEHm6ToSsLnT3I6eljFo3iPuYy
         saJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMj8lKI3Ondbn8c45ip2fAPE0+ZbM9Q/tFyfOlyErCQXr99z+aSMk6rSkdyeiq4lOIdH7kIEF3A1sKD3CUmy65PmqqBGya0kBXnjWk
X-Gm-Message-State: AOJu0YwksqZ/dhDmLHrgj2kF5dMCERKjAnfJwBQ4sYJ7/Xk2iHKopxUk
	xLXXT8omqkfPNeLeQnrB0zD3o/pK5NFl67fa79YyBgzsTxVQiJQk7LJD5Y3FZwxTyM5ZWDKRG+a
	/MeEle6zy8KYi9kclCMygOel4sIA=
X-Google-Smtp-Source: AGHT+IHXsITTB2kehSZEslm6XnNpuKpBfsQOGPpcXNU8z5aj/ScRUZOzVoJ/r5olLLBa19B+/T0qSgI7utb0ZsOq+Jo=
X-Received: by 2002:a2e:9157:0:b0:2de:d4df:4e75 with SMTP id
 38308e7fff4ca-2e51fd463d1mr72432891fa.17.1715614622542; Mon, 13 May 2024
 08:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
In-Reply-To: <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 16:36:51 +0100
Message-ID: <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, 
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dsa_loop_bdinfo.ko is not created as a module.

On Mon, May 13, 2024 at 4:34=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> Hello,
>
> On 5/13/2024 8:33 AM, Stephen Langstaff wrote:
> > [Corrected emails for f.fainelli and olteanv]
>
> What is the build problem?
> --
> Florian

