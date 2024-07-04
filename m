Return-Path: <linux-kernel+bounces-241112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBEE927727
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16581C231FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D91AE869;
	Thu,  4 Jul 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/fmVir/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8D846F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099585; cv=none; b=RmPDHBTWTzxPo4iEpjfVoQ6S3lOH2jN2b7BtWVH/wQseYY7QiabV0bVIE8M046b8byjw+D3qHDtKyqSDaI0dUzlVB/V34kEqmtfJN3wMNEh4qx4ViKpaB2TgdOu3Dnh14VGXdV+mIDJeJDxWYeC1Q2IR5omOZgCr9ZxkNCPSuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099585; c=relaxed/simple;
	bh=TaVzTCpKDgZG+VdQZ3FcaSSV6KNs+Es3hAkiC74Kydg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJhoBywyFqx0VJj5BUwC5BNTI73dXm0pnxKeTQTAB5VQz5X4bMgejkdsXE6SrgfgetksN4vDzRg3b5M+jlNmjFqA2NMcFAOfrufwC/yAY8f4wpf4eUUphvxoqEw6gRPWvpp1bkhs7BydK8fZuqkKTfG0UtceOketyOy/Y3R+61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/fmVir/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso334715b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720099584; x=1720704384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaVzTCpKDgZG+VdQZ3FcaSSV6KNs+Es3hAkiC74Kydg=;
        b=j/fmVir/FyCVqj+DD9Pz7qGnumBi5GzOSmUGL17bDNXRQV6gdyoWpKvK0sr0NhiyHo
         ASUu1HGAlVBSFqEuyYBykYqxcywz3JLkPUJE1JL0/4Ugs2Vw+4ZgGxdgIuF6Q8lfWIWn
         8q9JRn38U/0yVVbKFicaPcUgAj5vIx74t+cyuw1jRg3I56sPm885kX8uRHYjFUqRIJG7
         pb6jMIl8LDxk2q3c2axUIKMqIwjBL8qYCR3nPXH0MiTUrSPNRdYsQKN/iWGaQ/bcsvMo
         5np1hAcYl4asFIrB9RGfDXw8tjeZBG5Wih1q2VXo3ya4gqY+iByRCSsn1gww2V6ahfu5
         xj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099584; x=1720704384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaVzTCpKDgZG+VdQZ3FcaSSV6KNs+Es3hAkiC74Kydg=;
        b=tL0pX5osMqscp+Fw+tf2QGcF+uGm4Vgq25x+EcQcCA6HMhoDFOMpuYjLQmyTW4y0Sh
         lt5KgWAml9TELfwP69c5Sdd0+rlr6s+ykexqfV16O2o2Dp8A89yqxObuHZO9CVwVe0L9
         nTNIq1qFIRXbg6JLk9yKrL38ayXr9e3CNLFHV00t5uL3caL85Trz8jNyz2SUTGs5wCwl
         2HJ4dX6PQBF+4bbfF/CJHD5do6RmdMAegTkZqBDQ7toR0gw/V7H6ugDVrQGuG19tux7q
         B3VQjkWQYIwVh5+B6uRCuZlYbGNxB+sWSkgN9xEWharn/nRT9Yvhz1LMPJm8xNiAA8jD
         v7MA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtu5P+v80/rBxyawnMs/FdmjSJ/TZd/yP0uetp0hz68Zx2jp0OlfLDqf1kUj77nvVqd9XzIWY4vyQHsJUU4pscATIg9VTcUP9EyEc
X-Gm-Message-State: AOJu0Yyv58zPTUm9JpcSZQT+4dps8P2QjFJqkmtVECZqEFsFHCSt8hQ2
	7o77dPR68ZrE2OEwtsf0lw9+v74VopfaT0umydxquMy+HTLQzrF0
X-Google-Smtp-Source: AGHT+IHbSroMnL5diSYrVgL/mJFXNL4zWVBDdG3SmCpSPdMUh9pV/LB7fswxNCb4gpEIyClqhuQ/MQ==
X-Received: by 2002:a05:6a00:1ad4:b0:706:6b38:f065 with SMTP id d2e1a72fcca58-70b00b98665mr1604134b3a.18.1720099583701;
        Thu, 04 Jul 2024 06:26:23 -0700 (PDT)
Received: from dev0.. ([49.43.162.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf757sm12200005b3a.104.2024.07.04.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:26:23 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: javier.carrasco.cruz@gmail.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	jain.abhinav177@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] gpu: ipu-v3: Removal of of_node_put with __free for auto cleanup
Date: Thu,  4 Jul 2024 13:26:17 +0000
Message-Id: <20240704132617.1003914-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <035757b1-5dc5-4966-9eaf-a52b707bd48e@gmail.com>
References: <035757b1-5dc5-4966-9eaf-a52b707bd48e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jul 2024 17:29:14 +0200, Javier Carrasco wrote:
> Hi Abhinav,
>
> Apart form having sent two different patches with the same title (hence
> the confusion), this cleanup is right from a functional point of view.
>
> On the other hand, the description should address why you are doing this
> cleanup (e.g. to remove the need for explicit of_node_put() when the
> variable goes out of scope). The need for of_node_put() does no vanish,
> it is only automated and no longer visible at first glance by means of
> the cleanup attribute.
>
> Best regards,
> Javier Carrasco

Hi Javier,

Thank you for the detailed feedback. I have modified the patch subject as
well as the commit description to better fit the cleanup task being done.

PATCH v2:
https://lore.kernel.org/all/20240704132142.1003887-1-jain.abhinav177@gmail.com/

Best Regards,
Abhinav Jain

