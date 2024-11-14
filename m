Return-Path: <linux-kernel+bounces-409431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978039C8CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E82B2FB18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4229429;
	Thu, 14 Nov 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPrpmWw4"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B12BAEF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593646; cv=none; b=LfGsyLBeNmKJTIF/C7u9wg5eWw4DRHAUWK6eQR2afKFBma05IywDItksEUUN4+gNMuYWKK+S4RDVx36eWk+XWpG+OoIhenoYIutw+t6iAGUwwXuSNjN7vCUVJNkyUCAGjulLw7o1cFgQoWFt3+RKw955F1PiOrQLUXTdg0ambOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593646; c=relaxed/simple;
	bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5w3JI+iZeBK0bDPIN8i1QYeUIaYzt8UT6ueBUQkARutPoKCFBaOd8cF6MlW6CeAp/ldhC4bVMhcuzRCxJGcKVlJ0zIy5AS5nTkTQYpkFLxjtCIOlcOGe7h6b4zAY1vRTt2Ev2JzQPMCrdtBWi01UR/JJBCmQPLsJy3qQu0ahyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPrpmWw4; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8323b555a6aso30597239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731593644; x=1732198444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=;
        b=BPrpmWw4zZ2vNHAB+InMS0iRRe+QOAsykcypI/rrEFJmfIh4NHSPjEtr+m/Z053Rg+
         FVCszlhKNjhDVeP3ihxn5ug6m5Xp3kx79yvv6oVuTZ/ajCOElxIjN6PE550gBETQh+VR
         +6jfmU77GbxfSq1pHlpUVKvo1MZUXCjrJrvi66mBslC961dIBIyiFKxwG+J/gVR9Vhvw
         4FlSWIF0/fgclYbAgdbSUzNo95kLbc6pnv7IIY+usG3VMKgdAzoTo16qMwmBt4VkgnYn
         xRATU1ZvimlIdYmNCtnNYpo+oPjkcKuZYVX6GcbsVMGbQReOO7kKtgIBkhYlSSK+gtxL
         SUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731593644; x=1732198444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAvre8wflvGFv4t6W/7XPF9jC0eZIV1+2ZaBm053M0Q=;
        b=c9QXYKGyrMO4nGEvrpwttE9SaeVV+Piz4xtZ5tRm/hqw/JLXCHESVkEHz1QSvu4eln
         A3i5dfxwoZr+rP3HLu8ENr3kFa9w5IlyopNtd5Fi2NrY/VS6+V4SQ0U9Q89ZkP8gkdEg
         OomguD1wF0XuL7X2WfMiD86A35T3Lg+biBMywnMUHH/02radV+nAY1L8QGOH56yd2v7U
         4dYRiZz8zKnBaN33WtPnMqRfNsRkx6dO56U1L1tqHRlK04SXdDt92QuqF/Tt9pg/2dPi
         iGjs6Wpq1tDDQFN+pYDfYoexDO4GDW0pKRVkhfU6vYn269RtPOLFHwV1XMRnI6pmWa6v
         Mh1g==
X-Forwarded-Encrypted: i=1; AJvYcCU10GpdNxNrV6xR+dHw3iVWVB0zwRIXYEHh0WRxPHg6fa5kT2eq4OgK5AJodLb37RdSUjT6NP0CjQqw4s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvY2MydlGL2iLh0Bf+I1iaDPDzrCsRL2HxywtJ/w5GdeNxbDC7
	LpRauezbF71oIpOKH4H+mYf39tNrQOprOpJz5t6FZ9CGJCMBl6pSTENOvdib0HZmZ7To+y7puQm
	bY/GyftfVnT2lfXOZkOchz8GaT8ZnbwQlxidqbGffHmgLfGnJkyfvjkw=
X-Google-Smtp-Source: AGHT+IF0O/N9QpWE+CuK8f7Y9RC8pylKpuXYuJyNPX6KXWbRNIdMzwXXofYiavpCsbDSHWWB6PWtZqFGfOB04vcJU08=
X-Received: by 2002:a05:6602:2d8a:b0:83a:95fc:b242 with SMTP id
 ca18e2360f4ac-83e4faa2688mr783656539f.7.1731593643838; Thu, 14 Nov 2024
 06:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
In-Reply-To: <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Thu, 14 Nov 2024 15:13:52 +0100
Message-ID: <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: axboe <axboe@kernel.dk>, hch <hch@lst.de>, kbusch <kbusch@kernel.org>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:24=E2=80=AFPM Robert Beckett
<bob.beckett@collabora.com> wrote:
> This is interesting.
> I had the same idea previously. I initially just changed the hard coded 2=
56 / 8 to use 31 instead, which should have ensured the last entry of each =
segment never gets used.
> When I tested that, it not longer failed, which was a good sign. So then =
I modified it to only do that on the last 256 byte segment of a page, but t=
hen is started failing again.

Could you elaborate the "only do that on the last 256 byte segment of
a page" part? How did you check which chunk of the page would be
allocated before choosing the dma pool?

> I never saw any bus error during my testing, just wrong data read, which =
then fails image verification. I was expecting iommu error logs if it was t=
rying to access a chain in to nowhere if it always interpreted last entry i=
n page as a link. I never saw any iommu errors.

Maybe I misspoke, the "bus error" part was just my speculation, I
didn't look at the IOMMU logs or anything like that.

> I'd be glad to if you could share your testing method.

I dumped all the nvme transfers before the crash happened (using
tracefs), and I saw a read of size 264 =3D 8 + 256, which led me to the
chaining theory. To test this claim, I wrote a simple pci device
driver which creates one IO queue and submits a read command where the
PRP list is set up in a way that tests if the controller treats it as
a chained list or not. I ran it, and it indeed treated the last PRP
entry as a chained pointer.

It is possible that this is not the only thing that's wrong. Could you
share your patch that checks your "only do that on the last 256 byte
segment of a page" idea?

