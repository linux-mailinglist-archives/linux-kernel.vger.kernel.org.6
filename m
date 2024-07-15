Return-Path: <linux-kernel+bounces-252141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DBD930ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A670B1C2117B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4211849C2;
	Mon, 15 Jul 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="TttcLTpE"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2B18413C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028737; cv=none; b=NAMj1p7YzDqX/Y3sNR1MOmQa1nWvqOkntMMT+o9j+kngElb3SPfrpVkT22slUergiqRIu8u3pjAiiPR/7UfY7WposwLY2ohLGUmxINF3NJoVXjD53lJXUpqJxBvJ26gLyHNPzlm+kXW6MzDV8OdR3cMvC5zbfNTuPcjdILfmgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028737; c=relaxed/simple;
	bh=kcvtxIEDXgyleJRD582N/TZL9b2vFR3po4BqgM2tRr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z8ZvlvqAQlPZVkvdB5g0qWOs4d3Qvf0BLrLktIF/PbipA0KSS/q5RHY1fb5wiDPzGSQHoAx3ecjwecj9Jh0WDA9EZ2fHNqIgS4LrpFvxjOyRhsuVrZOCXWJSV5aXj6kxM5/4xfebl5nTpbD7eX4hqeGS0z7pgk6/8zKk1OJicdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=TttcLTpE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d96365dc34so3445002b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721028734; x=1721633534; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6CswuAcA19Pr7Qir263TiKyjJHE6FeE4xJ8Qxw0DaMc=;
        b=TttcLTpEmcsQsejAI5qdVW7iIZ5kRf8gVozFl2G1ohr/15Z5t5xjjVHsGU4c6THWdC
         kQlRU2lSTKQAr1H3oq33XwihXgu9994J50+Nhae+hdotdrOKowLDA1i4NAgJhk/fHcIX
         JM9Ple7VJ5hUCW7BNXr2eOjgOpgtvb/qPIBdbjE+Mk1YckHsekjUor1xlcAjCOjq9SPf
         m02i//iKF8nNcQZL7Vo0ELarxa8cD50r+/VvXbUNMcvo53r/L9ZUiNxAHivdaOFCrS8I
         3swSj+KzlevoZw+pQweaaVwf1KawjvvBVNUzNoJwbZQ/TTQSc/t1ycJWzeEgPLSrDc1N
         WNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028734; x=1721633534;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CswuAcA19Pr7Qir263TiKyjJHE6FeE4xJ8Qxw0DaMc=;
        b=A6OjtwvxS7X5RYl08CYQQsRh0/FY0eRNXjBjqNryC7a1XVkpJVKZ6jo0g/gqLPImDq
         Kj6Z7ZYVQDG4mVEMcz2zX68tiS82blqWQJVIZ/Vpzu55uSZjsGgCHJMlyTNjzTUD3cuI
         bLesdFZYEgQtN/stsxYf5msRJk2nA+yQvHECKKreBQNT5aZr2L/tLcyvKw1I1rF+hxmo
         /9+1/kyo+vZ1qLB2Ffj2Vmc4WfInTCbkr/+EWHfTVN0/vbNkYnQv4OopcbTcRMju3fkj
         RG65w1Xr42dVS7lrvpwYeltwbEtehFmMLZr9P5+vzqKXhC+Jc00FZbyRzQ/m/rKfI1C4
         tBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx9TWgaBIx/b3vvtns0YP6s2ucyYQoAmr1Jw093H6Wi3oTv7tnCCxNfTmtZgtRdstZ8NE/nGIy1PGty3AJy6NZQpDvznddfL6I4A2I
X-Gm-Message-State: AOJu0YyofNKR7Udvrlo+5u3Kqajxbhu9PrC42qoaI17NOoUhoyZiAqKE
	zkMXjzF3eZGFRfHxZi0I/U/bysKI6errXO9W2GGWptgVS+TNfyK7UdUcYrhLYKs=
X-Google-Smtp-Source: AGHT+IFbm0uDFRsPJa0Nz1krahRsJcjD7FdB5iaBEphN/CcHhS8Ov/LHN0lN+9E9KFXJdEPbJMBvlQ==
X-Received: by 2002:a05:6870:3287:b0:25e:1c7c:3de9 with SMTP id 586e51a60fabf-25eae7efbdcmr14809287fac.15.1721028734517;
        Mon, 15 Jul 2024 00:32:14 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca75a6sm3654464b3a.164.2024.07.15.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:32:13 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	linus.walleij@linaro.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
Date: Mon, 15 Jul 2024 15:31:58 +0800
Message-Id: <20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes between V2 and V1:
-  1.  Respin the series on top of v6.10.
v1: https://lore.kernel.org/all/20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index a62916d07a08..bb5910460811 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -22,6 +22,7 @@ properties:
       - items:
           - enum:
               - elan,ekth5015m
+              - elan,ekth6a12nay
           - const: elan,ekth6915
       - const: elan,ekth6915
 
-- 
2.17.1


