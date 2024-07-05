Return-Path: <linux-kernel+bounces-242910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06109928EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B151F22565
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA21145A10;
	Fri,  5 Jul 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aa3WSvXw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655B145B12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214108; cv=none; b=PbywOJDX1mQbDYtyRz+2E70C2KWRi2xymTwJeHDpW5jpw6Tk4IWFOSc5y1XHGoR53Xyl+fvv9Z1kVMY1syljbI5EylYAkHT9LNaWxZwLeOa1YYBqWOa9o4DQ+UWyowaMXLXSKteP116MvToGlI/ruRdFuck1XcG95gyj3DTqk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214108; c=relaxed/simple;
	bh=jw8m2Q8SxhikYPSpGO5e6XgC5WWnQALTy43ul0xbcKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwAIXI482SaiEkKw1VA8X1mtUFxQwqNQPK5hPwkhYQnlU60jzsHfG9b6bAK11egg6MO/o6BjKDf0GD7JA2ADKThG+WposqE/QMhgseZgygowWQh4DmlqLxcVhEOOlOc7F0xbz1YhoMrREiOyJWuz87OMTYuchsNe4ak5BkQQLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aa3WSvXw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9c55febcso2650476e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720214104; x=1720818904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uip5gtsGJN8be4BC5gcYviodP+GbV+3zApaZVxbcrG0=;
        b=aa3WSvXwKfk2cM5qh8zsVYPHpfpgTV90tdCC0tNLQkChiZboaoTTZEWNASP84VARuY
         rx9xlEUpapxJGQhfz9gdqfJ9JooIUyvX3L13mOQONe1xXqRWmCUa1hiX4I9qsyVjDIOp
         /xV6JoyfEBovzAWHyXOwDrHY+qfUXBJfr5EfugzgNaWRvEqOzV8ZEZzxoRDDgMQSONkC
         VJ0Rp7eAewCDjywtkjAzbI8LOAx+S+LLoBi1LvIy43V4xN7P8vv4/4yr9hEhDM2V1XS7
         srFestvnQ4DyoSMWMcyEfdBCkQoJsFS9Hm3P6BayHuZxdR1Wutp/eJLkUzLZ90K0DJOo
         XCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214104; x=1720818904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uip5gtsGJN8be4BC5gcYviodP+GbV+3zApaZVxbcrG0=;
        b=NUk9v2zdo3w5yQzT4kb2ZFo7sXAecv5Id1jrep3tX4ccndes0jmt7LIVIUIaKpDiUg
         BaHj3TRtqyCgvlFKaeEDun8woOoiZ4jS21AF8zSFa3oRG+620Z0mzgcwNE7x239jc+1A
         AWn0/qv0OOL4ajsoeGPgnQiXspoTIc04R3QZFQgp8wK2Qmcyw25RHu4GTDsFSfNXyuFC
         bVOi+g/4m1jwrcbd2VTZBd8rDkFpUrpEy/WGriHPPjI9qeQ+LAEKtOf6kP5wut5CNhGn
         9FnOvkBwpVPogahLOOMw6C5qac18pf9J8Nqd4sOavZf/o1f0OxH5m7DjAhc/y0Fg9ka4
         I1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUmdwd5Miv92O7yOx/12GF15HrF5+Jw6ZSTq/3hgcGpzXKDlTMPP5g/+p8LACeCPxbCI1POb3WaCXTmImC4rX2lsNXixHZ2aCSvhYn7
X-Gm-Message-State: AOJu0YxK8X37dON0xuwUxyPIkuBqzGsUyqplPEAuh81iFvt2foDXfCEs
	ar6o5KibjAMlRKFep+A7yLSub3ZaXCiyqc3jkTiJCqG/ahraaTK4YEq849Yb5l8=
X-Google-Smtp-Source: AGHT+IF5Ap1gpOOKIeYhmDrnv6TWcHQ27uju4b+P8Pp6OHSdvTAizrxr2T6HxI9xOc7L/vWCVEbRCA==
X-Received: by 2002:a05:6512:3e19:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52ea0636acemr5778613e87.13.1720214103948;
        Fri, 05 Jul 2024 14:15:03 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b033f3a3sm682994666b.187.2024.07.05.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:15:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] pwm: Make info in traces about affected pwm more useful
Date: Fri,  5 Jul 2024 23:14:51 +0200
Message-ID: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jw8m2Q8SxhikYPSpGO5e6XgC5WWnQALTy43ul0xbcKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmiGJMK+QFWU9D9g3FagOCuuzwOs8vNO0cfgd/4 u1BgUtRureJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZohiTAAKCRCPgPtYfRL+ TtWIB/47LiQT3BQPF/H6bE9LJozKnweLcc29sF5trcTNndjr5H8CUkx8w9HAnxYoEThOASjHdML Owm3rvh9J3a5DrMetpHDEAPKfBWb8lUvF5yw7CN8tHa2EdHyDx42jiiljw6JPxhi2JqfFXwpz10 mWfdFOzQPAix9qzPSCHdB9BB+sLUuhNjIeaeaxjeOkH/jIsKSEno8xrvzaiYgkxOE/RxoaGQPNE dS0xiZv5KsSQReNYqOnGM6Rr8mXK2vLCNrLtc1XfzS4JFv47oGCLzPm0STGwGaJ30XlYC+hF154 s/dVGZoOr4KVsb7yEq71+3sH0iokiACknr65DkyJOQxha9gU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The hashed pointer isn't useful to identify the pwm device. Instead
store and emit chipid and hwpwm.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/trace/events/pwm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 12b35e4ff917..8022701c446d 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -15,7 +15,8 @@ DECLARE_EVENT_CLASS(pwm,
 	TP_ARGS(pwm, state, err),
 
 	TP_STRUCT__entry(
-		__field(struct pwm_device *, pwm)
+		__field(unsigned int, chipid)
+		__field(unsigned int, hwpwm)
 		__field(u64, period)
 		__field(u64, duty_cycle)
 		__field(enum pwm_polarity, polarity)
@@ -24,7 +25,8 @@ DECLARE_EVENT_CLASS(pwm,
 	),
 
 	TP_fast_assign(
-		__entry->pwm = pwm;
+		__entry->chipid = pwm->chip->id;
+		__entry->hwpwm = pwm->hwpwm;
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
 		__entry->polarity = state->polarity;
@@ -32,8 +34,8 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->err = err;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->pwm, __entry->period, __entry->duty_cycle,
+	TP_printk("pwmchip%u.%u: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
+		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycle,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );

base-commit: 6ba37c70795abf1d59976b3a49acafac14b72a4f
-- 
2.43.0


