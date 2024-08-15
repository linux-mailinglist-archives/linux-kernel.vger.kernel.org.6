Return-Path: <linux-kernel+bounces-288474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E59953A86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930EA1C2279B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A074402;
	Thu, 15 Aug 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rhfhnvka"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546E64A8F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748762; cv=none; b=WZPoX663nq1dGVieC6rV3FDfkhAi2bwUJzOn2GE7ZD6o0ZeXXyj8hv/7/E9vrvM5eeSxrHiEfL3dIdAufI0gwq7aElf1oUwc+FMsADqenYmN0yaKT4uluXAewQuVm6OOcUclRJEjbjMcnPqOvtfh7ZL09GRqxPGKX37yLhDyLgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748762; c=relaxed/simple;
	bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B21tw2waqYDPQ8UoZFqY+1EUvhfcoz/cYe04LZJ6d3alYgDTsSIKbpAhIz1LDz6WRtEomOS7Ve5dkm26jne24RUunk3Qqx8wX6PqTw/ip93RPqvMoIj/HT+pDBMyyCgkRW/op5xUMfFu3FBdpCr79AR1QtwAlN7AB9iTaHfZACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rhfhnvka; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-264a12e05b9so839886fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723748760; x=1724353560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=Rhfhnvkap/bhvZz1Heu/K0/lbWrksk56IRwLZ8DV9tYDzOmpvtaLtQzUOUDbGkncL1
         EzDNllGAbi3/bhrYS0Eg3q/CZRsBoTjRC9NUNBAUhF73sRjB0Sc9nJ9bRt5KWr05dPsI
         1/P/HD6haGOjCc8g++a12S0PTJ+MisuoQLmQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748760; x=1724353560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=nFlt0KAeSQ2mJUFIKHt8loXvmsbRau/oI1/cIHON+ydR3PGr0i0dRZ12d1TOEXb66p
         2ywjJz7qEBqg6M3sG2/Wx38Rd0bIEKzflPqqu82uWtZjjB/J7Bj+vKdqYXj6W8CLnQ90
         8dwR1OtXxgmGRP2gHZPjkAaIuPs6/ZxZATMjsK9XsYaWt0q8EgeK9D46P06G2NFvY7Je
         iQG19KJC366J3jqP6GDc2+P7AW/HqaCRRY3SYq4X6qui1X49FoosTOQ/SfoiCuL/ygU5
         NAxVCycoSE+mUx9AUFaHaL9YrId0j4kUSR6YBP/rcrcSA1jR+GOtIvH0ZLym3k21z/W4
         5BeA==
X-Forwarded-Encrypted: i=1; AJvYcCVreq0rSD/LUnSaXD65uJXDvQNeE4mQKUxkNTsRQ7xGiQip0PUsr7Ep3bzLuajuqbnSCF6lr2dpBL8Zgd4uxFYDHClZmqwZ9OG+2X4U
X-Gm-Message-State: AOJu0YwTeSBmhzUn2tiNlVs0/iXmLUARHBC3TpqkxsoiFhXlQ3BYJL3T
	DBzdcCTf51lDD/oDlMiCXJZ3GA4oMHfPIKGL9rZiVj1VqRb/8DRNSXPaZxgZWCqyKprP6xatbuF
	xcpjLtk14qZbB4CaopHBFX6/pSTNyjwMiIa0b
X-Google-Smtp-Source: AGHT+IFI6hSc7AGc/sW2JQfBUY/KniMDdNgoq1mzxNAQkecM/83LRUyAO4Lxl0MBqVBAVhpmGep+xg8wQQC8nX9vvQM=
X-Received: by 2002:a05:6870:d609:b0:260:fd64:60f2 with SMTP id
 586e51a60fabf-2701c34a69cmr661045fac.8.1723748760099; Thu, 15 Aug 2024
 12:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org> <20240815095928.GE1532424@black.fi.intel.com>
In-Reply-To: <20240815095928.GE1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 15 Aug 2024 15:05:49 -0400
Message-ID: <CA+Y6NJGncpn4+UjgNavU0gAcChJZ9dji9_sBmMr85oJ5Eo79cQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:59=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Esther,
>
>
> I now managed to test this on my test systems:

Amazing! Thank you for the testing! And also for the continual prompt
responses. It is very much appreciated.

I incorporated all your minor comments (debug lines and comment
deletion) and added the commit lines. Submitting the third patch now!

