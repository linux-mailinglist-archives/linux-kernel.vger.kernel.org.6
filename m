Return-Path: <linux-kernel+bounces-233656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A491BB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA581F21FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27A155322;
	Fri, 28 Jun 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UceR3ffq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBD14F114
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565644; cv=none; b=PS1FaG0Vr3eDyw5hFXUgMvZToAiyb5p+XfB55nZQNnodEe3mqpRhiqSSyrF5oPZrFNwk5GPf0vzGOJfxdVTAQUDVoeKEBEHns0GQySEsscjw79HJ6GLulFX/AADXGqHY7ggw25DqFJuHGeqsdgTDhkIQ6EpjS9NMcQN1VBl405A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565644; c=relaxed/simple;
	bh=t+G3fd+ijv9xUdbGUKk79N+1x4Cu8Lqf+seYfUdMczk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTvSQCsZbRHNieN3UflrFBIasMC4NAmIAHoRrOjFpEg6fUXEbwds9OMhzoqQS8DPJwXNMiryndXf5DUqk79izlPzmRpruiNnx9u4MXEd17ibaBuO64DxUn3r8ymL/rFeZ5YXTiqaBAzqFE0gEl+P2Cz2IoTvfloVRuKen1Rh9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UceR3ffq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso434473e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719565641; x=1720170441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB5EvDrakOPexl9GfGTU4JrWCssuFa6ZQG7ub++KlZM=;
        b=UceR3ffqDXvl9HZm08vdBJIwTYA+P5a8X4lQ3uWl+uk3MJOTkDP9c6ohElUu8rHGHY
         C3u67QnC3Y1ut6KTx79Po/zJ6NSZoZCFxMHdk/JOLRzFIRT5zg3es/Z1w66g2dZ9qTNv
         gA5QObfSk6UFlFzXmhmBykFDv+MPWGH2rrZcLcAmr1hpw1y68HLn+a+E1tAwYZ8dHhYC
         KHWTsVFQ/fg7h7kcfgZU+LUoxhHbYWTGsPxXVvS6GfTz4Ilkqe6Ulp6R5ZeB4iFN404o
         gmGhZBRXjfLqd3ym75LeyTb5sRPYWifeOmhR7VRI6r4dspjq3f+AEiubDSkXpzOL2B7O
         a2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565641; x=1720170441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB5EvDrakOPexl9GfGTU4JrWCssuFa6ZQG7ub++KlZM=;
        b=FRNl2p51ImDVGVyEjrvm3yn7DP3ROxi75fNkoF9aG8CUqQazGVDfgKZHMNJG2oTfHE
         r9IeBvrgIlOMAvx+8cPVsMu7Dxts93T7avYPtp2zOzjCGsdlboqcrVnlpxcsJ8BHGDbD
         Fmd8YxP9DcMT2cUhPLwPUIWIQcGonh+KZoT6Qh4LPul+TSsbrkV0OdBDjsm79kPwVTox
         Zq0gAFcnNzqsYnQyRCnDJoQ6y3HrSEWmwWEER+JbKj9LwLA7+peFat0CO/zcKqEdmyE6
         piGJQRMOhTr45xc8C1yn+dUgB6G6wHndQlD2VDrAai29CDnvwOnPuflzhH9SB68071F0
         9NSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkenNoAO3hFW8nKXjmrCCVuXC6OEhIOWPX2rd5gINunZ8mw3Rl6I/+Q3MpTLQGG55nngnVNHFdVTcI8hYXLxhbQvax7LWliaD16Tfl
X-Gm-Message-State: AOJu0YyDoFfq9+VbONse5HcMdyp+6wtrhfI2U5xRuaH2kEsqlbcqzbvZ
	PO6M7OWQmbc6ekIzbTRnbpTj+DFby1SomPyjB6KXd0bm81uaDtnpytOvbSVi9vg=
X-Google-Smtp-Source: AGHT+IHR5Ql6wS15UNWAOVb5aKvdINi1DnDQLmYnWVu5yPtbmbQXdKi7BzF02P3kLBpPAnSoB8LhRw==
X-Received: by 2002:a05:6512:2083:b0:52c:e040:7d9 with SMTP id 2adb3069b0e04-52ce0680398mr10053969e87.59.1719565641000;
        Fri, 28 Jun 2024 02:07:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb967sm1612896f8f.82.2024.06.28.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:07:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dmitry.torokhov@gmail.com, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
 benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
 jagan@edgeble.ai, quic_jesszhan@quicinc.com, dmitry.baryshkov@linaro.org, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v5 0/5] Add kd101ne3-40ti configuration in driver
 jd9365da
Message-Id: <171956564012.990484.13901393761695275896.b4-ty@linaro.org>
Date: Fri, 28 Jun 2024 11:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Mon, 24 Jun 2024 22:19:21 +0800, Zhaoxiong Lv wrote:
> This kingdisplay panel uses the jd9365da controller, so add it to
> panel-jadard-jd9365da-h3.c driver, but because the init_code and timing
> are different, some variables are added in struct jadard_panel_des to
> control it.
> 
> In addition, since sending init_code in the enable() function takes a long time,
> it is moved to the prepare() function.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] drm/panel: jd9365da: Modify the method of sending commands
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/38cae7b626ec7b89cd14f15efb36f64682c76371
[2/5] dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e7f5112ae111a125366039666e9c6ff8dd71d0a4
[3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/35583e129995164aebb169103fe64614482ccf8e
[4/5] drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2b976ad760dc3a62e4ff4c4e5afa02ec16e4013a
[5/5] drm/panel: jd9365da: Add the function of adjusting orientation
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e1c550898f75eec9c6dcfc16a584d5bc58eebf77

-- 
Neil


