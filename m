Return-Path: <linux-kernel+bounces-401284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D29C1831
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E734B28530D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD871E1A3C;
	Fri,  8 Nov 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHFJIz4o"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791E1E0E00
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055118; cv=none; b=f0ib5FqEu6s1QTw9dMJtR/PP9gikXeqdRheOtuwxwvGl/68CL845rxzhVwbd1pg7wB+FCJlqN+CzxbV2lzUNtFAOlqXLj4DUMalUTu+pDk2YGbjeB0pv07qhZy1Lnj7A5a5VxwHIjnFzLwKKRCbvL9Cuh8kcexUbUNjIlhGHOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055118; c=relaxed/simple;
	bh=8Ku1sedz9x2rq/dvX7LG+oDWcXmHzu0hzt6KDenhML4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxNx9B/wVGBmFZ3ndjdbSREeIbG+JG8VUXUbuX4C1YOLR3ljTw2WsUeiam1WPLjdmJSLT/aPrtxsRzz0LWjND+oQQfnED0hDBzV58GXOSIr8s5WTmlkS5H72ECuv8nVZ/hzQH4TOMF3ZLxSOI+2Sj3neM53IEnkn3+J5wCx3SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHFJIz4o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43161c0068bso16537575e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731055115; x=1731659915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6NxAbjHQckGIPmfMDQLA0AF3eVsT+4lOIj+mWkhneE=;
        b=YHFJIz4omRul4CtgTeUIccryihMQMJ8JEqS0f51X0miM9ODbWSeyrPyrjVF1TJYeoD
         le2vW94M8Y2dzcGrqMBq1aEZ7r7DrlSISW06iCxqAhsoA+gIhZOCTgwrEiqMsuCV4Bpg
         MAXerFVqWOC5rNAQKq8yzG07Zg9SeuI7ZIv6W+aEjR96Bgm/2M4UPGRBkDWJgRCuDU+C
         nSV0oAVlwAG8jjV7Rw3N/F6k6CL+le694Bs0ubXTw4DSL+KTg68YmzX/k3io6cC9a26m
         8q8pO75evmEoQEPnaj/2oMNpqSAkOpZvepiTuHMAl2key6PJ3bdrrrCsbMcrP2cBgIE1
         BVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055115; x=1731659915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6NxAbjHQckGIPmfMDQLA0AF3eVsT+4lOIj+mWkhneE=;
        b=NLNG8PyUKb5yzlZ5YcuzWEEHDn5QUx8yxuU89EOeriHY6rOUnmUfPVK2oZgbDOE1wF
         J7RV7nDdraCPOB4RdBJyVjo9GDk1SncgPdZ3RNbHYhjKQM71c/dwzibQ+Ubpz9NWfVoE
         Li1ALWF4A1qT5urtKt4p9suQbySlGvD8ty3/YaSF4eGDSc1JE5DB+E05kx4LJzyeExyQ
         nR8Dsb8iPQmdZx6Mm86yDnY4qqF1jrdt16z1X+enSf8Mddd6zyZMyqymDtIkn/pP9pnF
         +RrUqTMmXbtmf2vSQJ6X81buV/LO3tjtvorTKE0pVVrgwTnKguC3M4KbBHrV+myut6u4
         LPTw==
X-Forwarded-Encrypted: i=1; AJvYcCUAey1PKQNk+5j6vEEAaQPVmIVSSPycAXKoGG1SYk4xS347jFSYZjwtNnz+FPppb1/mH29TkMGhQfk5vKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCr36esLuhFy1a0vJonQbPvSJd2HGzGU/t7X0GHqyIialhkYIb
	Pug8DRGHlSpq0XbctnXuwKQ7RIEVXy/d1AF4OAmE/maGsiMtY8bbenP7abdQxmc=
X-Google-Smtp-Source: AGHT+IEe/fQjcb8mQhhc/3k1y6MNaZGFvf4BucBtabIFpnvCupkzC0jAgMklL8L1PB3nc4BMoqnoBg==
X-Received: by 2002:a05:600c:1e24:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-432b750ac1emr15609375e9.17.1731055114836;
        Fri, 08 Nov 2024 00:38:34 -0800 (PST)
Received: from aspen.lan ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05f89sm3889986f8f.98.2024.11.08.00.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:38:34 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: jason.wessel@windriver.com, dianders@chromium.org, 
 linux-kernel@vger.kernel.org, Nir Lichtman <nir@lichtman.org>
In-Reply-To: <20241027204729.GA907155@lichtman.org>
References: <20241027204729.GA907155@lichtman.org>
Subject: Re: [PATCH] kdb: Fix breakpoint enable to be silent if already
 enabled
Message-Id: <173105511408.10030.381076759975353405.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 08:38:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 27 Oct 2024 20:47:29 +0000, Nir Lichtman wrote:
> Fix the breakpoint enable command (be) to a logic that is inline with the
> breakpoint disable command (bd) in which if the breakpoint is already in
> an enabled state, do not print the message of enabled again to the user.
> 
> Also a small nit fix of the new line in a separate print.
> 
> 
> [...]

Applied, thanks!

[1/1] kdb: Fix breakpoint enable to be silent if already enabled
      commit: 1d0de1fbfcbf480b785f3e57a098977a5f6722c6

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


