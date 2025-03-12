Return-Path: <linux-kernel+bounces-557700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB07A5DCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FBF1746B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D824292E;
	Wed, 12 Mar 2025 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoujRzdr"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40308242930
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782605; cv=none; b=aVs5u7/9UGblDxi9Mp8GGUkX0i69VdPOsr3F3ndyJPrlO09oDeus0b+voC3R+0JkIX6E57DOTDnCH1qNbJJzRk1F1G2YFDoXX60vtg4K1kfZxAM0i4lzCSH5qOnar2dqJ4IXlJg9P10Z4Wx8B8TXsk6QvwY9g68fgGg8T5OXS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782605; c=relaxed/simple;
	bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbfSCLb72SwjJYBPWMeneoMsipRmir40ambBhc/JOepLEtVdkc7DhNeX0taVmK/k6MRmWknNHMlC92ykpRBTLEqmCL6tjiIwiazUXfDYwyvG5d+AKnhwKPIUqgshNTT3Q/VYwUMgxB0Z9uQO2XcCRW1kItyOYGDX4pVzGvYEB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoujRzdr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feab7c5f96so54605857b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741782603; x=1742387403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
        b=DoujRzdrvsDbRxmvEdU6RyU7B4wTmEvvvSr0rlnbp6sW7Y6gQIM1UHbtrZ7bZUMLA7
         s30IFFSEEvmw937dSsM8BYSMGoS/wFqR1BYEQYeCd1ldvlyrLJyjCm5LgrSf37eGM+x3
         YvWKIIIQ79+hyN7D41P4sq0w/dE8BV4+G1adUV9gjI1AJ3Y6T1gj3CiDobG5MAaXDKMP
         FEcMQhzjETeTimdM0xSR30LFFz14nP32xFjY/4ylvoSEwP/Rf/Us6IeOUnCETcTjBIy5
         zmA4v35UEloU72a5opGC7hHnIgqd9cI0hhxL7H7X6D6ZGI3JDMhEe/upa+btIfeK+rbQ
         yNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782603; x=1742387403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
        b=Ekqb40wxs4QM84KCNaTpdY/nvjfasiq8Sr1lveNbuXHDHqkjqViMB0VtxbIUvYIhWV
         +PppFxEepA+GGTWillw4cxeV0fzUQmoQGWRBETb6jr//+UunJmxhlAu0GuT5oBy3j1q9
         iJiRzSrXlg9/QYGfpyM+7bk1v906nQ8TidXLZ2dmkY8s5I72OYBOzJ07P3PAQDogyOuH
         Es7oxNg1Oz3F4DAOq1PkcpzbiC7ahW+92fC1dtca7HgyEpwDVXqeqKwkvbb7uA5wxsir
         MCesPb+ye01sVUJCJv8Z4V9QtHiz2hFStxBFDoqFx2zo7oCQVHcBUCAAVck3A1tUiFdR
         q1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV47fdyDKzWgjV+p0rlsP3uWMGGEYXzEKBQ9dw9KkdEXPRC+EcENoRAPCZLIBid714nfTIMYvm34Hj1lWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kQhROZhMH1gmJXcIwdSWjJ5Z9IozXDyXgUQiySVq8qb9B6AS
	HglNXM6k5PR2k1davbXfdnVPqn0qZPgWjXlcjpNbacKyy58TKKEVD+eJ1iH3l6vYqjaz4UcR55J
	xAzhbM/JEN1EAZKgj/hBp73WsxU5qhEGtapUQrg==
X-Gm-Gg: ASbGncui1E8hFxw9sB6xXDSB8C0Q9D2FzLiSTYdVl82rI/YqRstBl64dUO/rTJtrOlq
	ObUt5x6EJ11IAn/JkJ44Vjxt2kPXs/6OQUtNBsurl08OEIKVPxQ+d0VWX2TxoMKM2UwPi3qaLlO
	lJfB3RaqgZzC1thk1wQxj1WXEMqY0=
X-Google-Smtp-Source: AGHT+IEOTymDhycwj3x4XJrFwn3GpynyoH/McVtHYKr6+MpNmJH9id1TqdMVe93G58v4pKq671t9MEut6J4fUtwcXvY=
X-Received: by 2002:a05:690c:4b0e:b0:6ff:28b2:50e1 with SMTP id
 00721157ae682-6ff28b25a30mr1908277b3.2.1741782603185; Wed, 12 Mar 2025
 05:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
 <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org> <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com>
 <4e7162dfccbe44468f6a452896110cc8@realtek.com> <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
In-Reply-To: <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 13:29:26 +0100
X-Gm-Features: AQ5f1JojhidGObyleeO_01vFJ5qMdpz0_jjjac4sFNZbF6OZFcRqoqIx5daA8KI
Message-ID: <CAPDyKFqyWFfyhkyB4ZA+uH8YanYbb2safzL_qM13vCDDyesPQA@mail.gmail.com>
Subject: Re: mmc0: error -95 doing runtime resume
To: Thomas Haschka <thomas.haschka@tuwien.ac.at>
Cc: Ricky WU <ricky_wu@realtek.com>, Bart Van Assche <bvanassche@acm.org>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>, 
	"martin.peterson@oracle.com" <martin.peterson@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:53, Thomas Haschka
<thomas.haschka@tuwien.ac.at> wrote:
>
> Hello Ricky,
>
> yes [1] and this issue are the same. As I only have a Surface GO 2
> at hand I can not speak for other effected systems, though I guess it is
> reasonable that others are effected.
> It probably works for some use cases, as it only fails if I read a
> lot of files, like opening emacs or firefox ( from the SD Card ). Which then
> causes symptoms as outlined
> here: https://bugzilla.kernel.org/show_bug.cgi?id=218821
>
> Hello Uffe,
> I will try to see what I can do with MMC_CAP_AGGRESSIVE_PM.
>
> All the best,
> - Thomas

Hi Thomas,

Any luck with disabling MMC_CAP_AGGRESSIVE_PM?

[...]

Kind regards
Uffe

