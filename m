Return-Path: <linux-kernel+bounces-335096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D497E0FC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16319B20CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D616C453;
	Sun, 22 Sep 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpye741E"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E115350D;
	Sun, 22 Sep 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727002273; cv=none; b=DRroeCVHYlEqZe+XtyuQRNCqEHTq+HeLSlkzODUg6f9Xg6cxoRSLY4L2uJkKoZjcEOlK86jVZ2CE7cA/w4yqBtBIewqb61HCoVoKqIoePxXiLVTsMXtvqyYA9ekhVZXhUuXa+hK2DecjgYE6Zq8Sj2tf9O4gWJ3CseASeRLwTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727002273; c=relaxed/simple;
	bh=jsttPtJVWzFyEmmKiqua/zeHhWumw48JgBa3D1OyBGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwkE8PG80YWP4hrVQzT9fefb3KgF7enEBlxGf2sfaROctmhkaRci2tOtlXcKxsP98z4ko964dL8S6xRMAFdl8pqaIzsRGa328bLknfy0Bv6Rt8RbCvceBI2leSwbVO0NdFFXLptd4IaauO/T/1mozPGxXVR3l+qEiRn4TE3JF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpye741E; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7198de684a7so2639800b3a.2;
        Sun, 22 Sep 2024 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727002271; x=1727607071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfaKNPUCoZktFoxA7ex47D6NTps/yVQORN1Hk0vnOKM=;
        b=Mpye741ETo+0mZxjBD+vkCRuFIwu4pVH6UFDSdDq1Z63grOW/nEnovJMZ5RzXOQiXR
         H5NF4SEKxYJ3GWe05a2WglYaoeFbHB3hT/zQDy3Nfn+/zRWJHccAoLm7xhBrhBC4ynNX
         U6POSz73I7PuJKIxoDHgGgLtds/v2rMpZ0tlWJxsMA/OaxNEo8VouZDiax9O4+4Z/XNQ
         4Cq2eoVlL1IHaH/JWIn2KJSg71SpF4IpjhH15f2Xb8FKwJaspwSIW2/qrcoOtpyNVVba
         6ED+xYiwTDr33AICKulaae6eSNmRmkVwj2lbgu2h4tfcykUB3IR8prLqV9ocz0q7fEZE
         VCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727002271; x=1727607071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfaKNPUCoZktFoxA7ex47D6NTps/yVQORN1Hk0vnOKM=;
        b=ouSknlL+E2SHOhoCTrvfurGP24sgMbtP4Eaq9j7MFKiFlqmkMxFpbDEWEiF6nTagB9
         Y1MKt1PmYiB1YsrdOdkmWxkUrU6xgujIQxEM8TbNkmN9jiGzti9yYlqN6H6symdrXoxi
         Ag9ptQec1GNHX/p4F8Wwf6KUMpybDthvemECfGRkD2mpAyq+SzKijNE3WUSrvSrhxyeR
         B60cuNMMDcIrJZI0QXWpZGjWaYbXqCduYdq6G1COjVWbtRg3WsCKaZ+vfEZQLaC9A0ho
         IZmZPRnzsWvmrfgGuLPKaDVBV+mfY92up5EF8QX6K4lfppgOBuckWx9ggwIVASJOLSkU
         G7rA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXDLawpkXOLkoES/5EnN9Ud4St0nU+nxzk22a3lJ3R9lmo3qJx3RTk/WCvWknOlDIzqxUBzTVuRuCPbKa@vger.kernel.org, AJvYcCX/NM7ySqPqEjgOIQH+WlFZIE79IcDYsZ9w8uZSjNMadbCa9m1vDoTE3lGp95r52Izkrb36s3BntAXx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27REetxHvU1EXqk1kFkPB9ZFfJtO/dOlzI65M2ylw86Qgh4zP
	lUZFL/RPTKZvOkf76eSP9AUcA8m1ffWfeUiqjmf2Xq2+16mfp0vF
X-Google-Smtp-Source: AGHT+IGRjH0l99ssN+QztozL46uT4nQHpNyyqkPhdTF07mheLJ1v7yxUTrAsF65SBGlcz3QAtmY5qg==
X-Received: by 2002:a05:6a00:1818:b0:717:81b3:4c7a with SMTP id d2e1a72fcca58-7199cebcaa9mr13621819b3a.24.1727002271429;
        Sun, 22 Sep 2024 03:51:11 -0700 (PDT)
Received: from localhost.localdomain (42-73-147-23.emome-ip.hinet.net. [42.73.147.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7afaesm12300497b3a.130.2024.09.22.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:51:11 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: didi.debian@cknow.org
Cc: andy.yan@rock-chips.com,
	andyshrk@163.com,
	conor+dt@kernel.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	minhuadotchen@gmail.com,
	robh@kernel.org,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v3 06/15] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Sun, 22 Sep 2024 18:50:45 +0800
Message-ID: <20240922105045.157612-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <D4CQTRYUPQHL.1Y42CT0P8ZOWQ@cknow.org>
References: <D4CQTRYUPQHL.1Y42CT0P8ZOWQ@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> Maybe ``From: Min-Hua Chen <minhuadotchen@gmail.com>``?
> 
> It's very minor and Min-Hua gave their 'Reviewed-by' tag to your patch,
> but they found the problem and I thought it was just for practical
> reasons you made it part of this patch set.

Yes, you're right. The reason I reply this patch is that I am not
sure if I have to do this.

Please ignore my mail and sorry about the noise.

thanks,
Min-Hua

