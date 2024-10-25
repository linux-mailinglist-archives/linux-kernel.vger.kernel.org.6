Return-Path: <linux-kernel+bounces-382157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983D9B0A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B52A1C219C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291B18C034;
	Fri, 25 Oct 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVfCHo0Q"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A8189F2F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874560; cv=none; b=jOlE985xn7ruziN0hmsOgoDA4t+yzKm/P4awTt1lDjLRumw2O3vjSkcqrU8fmBFi0ff/u1ZVhruGzJvHMfsO3ROfZQS6T2UxvrgfKcuuIW93s1AZ0GQ2HT/Osj+ocELbMYUDf8qi9r0XrtfGjDalucRmvJfIQPa+OocRm3NjVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874560; c=relaxed/simple;
	bh=w0JT1TqESpVV9gsS7lH9mOWo3pQnOkcgm2i/+kqVMjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uXvZmsKfQZ8sc0YSG8pQzLbCL8XYTupWQNg3E9TftoR0Zfleqc73dtQUpqbAhiktZ/gkrrrdo4169whezZD40MyPxtz4FTTrw9xX4URs1iPdjKxqs8/V4ChQJBypu3wZBJhD/v3VONuNI69ulQRNSiIYTAcdWsubiQe/VjqYqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVfCHo0Q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d3ecad390so2474213f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729874556; x=1730479356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O8Uc0wNSl4D87GHeRKCxI8rppppACfX2yHi51S2vCI=;
        b=WVfCHo0QKhJHVJtdHU7ZXE1QZe6KOgLy1kd8DQnTdTngbF0PU8uwXd5apVlXD54icx
         X8dmFM1ESPYWadeynmNpMlB9jx4hCIdt3fjha1CQ4BRP35KFPV7+qdIqSnTh9cvYU40F
         58+eeRWAPSYaxWJjOazLCwlCpKA2vh83AmeqgAbqMW8tB4LpBmTawHv+D5WhIHa+dphe
         IOVOHcz8XhdChODdiC7Z5u2h0g9I8gS6nxj9wSWZeDhoipFWuz6jp1TtC6Dq5aZV7SuY
         OuprrfY31oRel4/cgzDu33fdoINGFnm03UJOJGe0xFsMcAGam3yvjl8anoXdRpFIF4ce
         pNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874556; x=1730479356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O8Uc0wNSl4D87GHeRKCxI8rppppACfX2yHi51S2vCI=;
        b=FlKu43/eL0kmZSJXGAq7/WqqaLeCFZHZeYaHXsMPkPcV6hkcYO7repExa7wb1qNTgN
         Onilu+iSoKiWxSZZWo8rlMYXJ0W87jGlQ5y6xg12J2fc/hFHFHoQANMCCrbw0Oj4YMy4
         161iAJTOruxBxnp4zh13/F5Bg8K33ilZdelcwunBZpfqUGhQGzIcgxzYU3L19dIujANK
         Giz65b2hepNSN9JmscqsfLcpm+kxleNG3fCotM30OaRK0oVQpRmZuvrPMA3etCXJcFPL
         CP+1fwAPay+cPVoSOFrMW5CF6K5+3gdgFxHnrBP0bUUcDwFWuA5lSMJRnrHHCMHkb80C
         2pPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGXM2wALr8GArpr+VP2gXrGHQXbET94fDPZit6gz7reG4Pyr64LFrVJTbdr2/rOeC3TbJkvYF8zLpnMpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLkIYL/s2q1ZFmzY7y1HJ5KFkjo8QgPlOy8K1sZR7tkJPZGo6
	L15ro9T2L9cONM1auLFZInmLmIDaozOS2y/0BhTyUYluHCOn4vSGQTtWFLmPUDE=
X-Google-Smtp-Source: AGHT+IGWWlWECktFU+fFJCf5hYHzpUI+6GWpy6U6Cca42a1A4pI401RfzC4B5K/VBVBk4wLfYXYleg==
X-Received: by 2002:a05:6000:e88:b0:37d:460d:2d07 with SMTP id ffacd0b85a97d-3803ac21c2dmr5083831f8f.10.1729874556540;
        Fri, 25 Oct 2024 09:42:36 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1cc0asm1992815f8f.10.2024.10.25.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:42:36 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240920021250.4758-1-shenlichuan@vivo.com>
References: <20240920021250.4758-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v1] nvmem: imx-iim: Convert comma to semicolon
Message-Id: <172987455573.287868.16389296993768691961.b4-ty@linaro.org>
Date: Fri, 25 Oct 2024 17:42:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 20 Sep 2024 10:12:50 +0800, Shen Lichuan wrote:
> To ensure code clarity and prevent potential errors, it's advisable
> to employ the ';' as a statement separator, except when ',' are
> intentionally used for specific purposes.
> 
> 

Applied, thanks!

[1/1] nvmem: imx-iim: Convert comma to semicolon
      commit: e2ba37350d1d95c5614defcec32020479fb5148d

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


