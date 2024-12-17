Return-Path: <linux-kernel+bounces-449633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D89F51F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799AE18881D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4B1F8660;
	Tue, 17 Dec 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luGFw+xh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85C149DFA;
	Tue, 17 Dec 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455516; cv=none; b=QR2S2Ubwq19cR8p0wH2JiohSEm4y0xCo4kxlSYdhmxRd2mZJg6eOhrnNSAUsyhWzzFbsgo7iE7EslwQjIfuLf/43/Z3GMDpkg5FHCYih2BrpB3ZCGZW1JAgckTG/U7vA5DZ0nYi+HiKJy/GgiCnH97e9ELtBCcUHCfagccvO4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455516; c=relaxed/simple;
	bh=5I2Fz+Zw+MQQod4tC46e0e80mrv/zcGvwwgYR+3lAG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GIjbr/tzchA7cEbOQwLKWjgBrgYHL9Od5p3Ej3osPY4ncvKxEdeu8wcXRcRW2HWUAMRKewiVmLtT0r2lqCTwMdgqstAhEQh4R06YQe0NG5uPFw1dUbC7HVMOSA+HjImyJwhjI/J4/40ISEcI4gb05Rb8hxElYjvv60opJlH8fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luGFw+xh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d161947so2688061f8f.3;
        Tue, 17 Dec 2024 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734455513; x=1735060313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDe+OjYsEchyhWL3fZePRFw+ytkHRR5OcslzF4bh7Go=;
        b=luGFw+xhaPBEMUvHVoKqgMENJhbNefJCHVxRRLS4YZ/XPuiewNXkEdLpuQcEZUVzKE
         1POYtRrwtI4Pid3dF0Y+YP/ySW9JGipIqCUq+vjliiANek6tp0+F7bQ/xMmvP2r/HXsT
         DUPVRKmOY4gWkcf33lF+pqkw7Ac0+Lxg421gPyKWQ6qGFwEcgmLjqUzTzP32fjiXS4qi
         CyvF0qJMeNB8mGUop1o6Z5QFeNBZy7o5Lk7x32rFHJSoIO/0/AnY6LU29sf3+fzUXHNW
         /gBjkrFtrlsrduRNXIB2yF3MVATQW5mfS3TJM2TWCaCJCId66UdUeQEiXokEHkPCop5/
         OJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455513; x=1735060313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDe+OjYsEchyhWL3fZePRFw+ytkHRR5OcslzF4bh7Go=;
        b=U5riV5nBTNB/FVvdHFy0yYo9mFpv6oVxw8+D+0a0Yapmz2d97PhobnDYB/abCURjqr
         6H60krtg7+CdnEPTyEymNssaUGB/nBpCzCOQR6XokmXlN2r0OZobfiwUhc1bwtLfN4jE
         9dJ6memhV1Gl5Wp6XLWLnonfCKNOd/ninO4ESDoTrRyplsgtdksZO7PXpVMHCFlos+Xu
         Fmi3BCNqRxyDZNJ8B4XaVGrqFHC0jq4dyrm6NAr3cx3SNwiejDa+DjVu5qt2PTri0OU4
         7892xggzJ+0gBdwSHtP6A+FH+VBzcBB6FGs96yLKbxV8hFQFYl9UnltamV/jMp2uBuNr
         sE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu45BjE980w9kBoLOKbfxiPnxis9Uaqu/0s+KbKgH4Xe9BmdzKPGe13BDrK58w5O0Sd1yjCLi+wTU8Kso=@vger.kernel.org, AJvYcCXW9rZbh1SlcixfXWUY3b8Gt9YMuZcpPgoyj0FbkqBe1rh+43Wy5sojpnQ5fix2Y/LLjHEMI4qu4zMCdgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzji7As887lCH350G/XwUGQ6DmeBrapVnT3BhIf8OuoBwGdEsYu
	IPSCIcM+5yFKKsdMkocEMhhIL8zfqNMydvNaFHY4COZsZ7ZHDNY+DgmU7Q==
X-Gm-Gg: ASbGncsfn00XSnHm5h5Dbtl3ebNyj6o9gY7lI6tZMTQeCgyCP+NF457iMt2EqxWKIXp
	BY0UzCVI2r5qNERlusEZGprpXz6uVzexvIzmSMJ6HrB176bApIFZOW5C0FkL+bTnvAzfg5diZFD
	VKDgF07t/FwW5TceFp4LnLCiYTFZYmZn7dL3bvGYJak4a3MqNrW92I1meq1LnPg43HDQQt0OIBx
	XIWhyJb+rJ3eA+z7ReRnU3DCCSL72hpnNu3zrpcUv+DD9GN7gPZUKPUFw==
X-Google-Smtp-Source: AGHT+IHEAuUoVlbNVbA7z8LHgDBOq8SuDDK7gMuVqYHCnWWTwXRtt81eXUzwttb7CKAHzFK2a2wCvw==
X-Received: by 2002:a05:6000:695:b0:381:f443:21d3 with SMTP id ffacd0b85a97d-3888e0c0840mr16149664f8f.57.1734455512939;
        Tue, 17 Dec 2024 09:11:52 -0800 (PST)
Received: from localhost ([194.120.133.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801211dsm11616848f8f.17.2024.12.17.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:11:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: soc-core: remove redundant assignment to variable ret
Date: Tue, 17 Dec 2024 17:11:51 +0000
Message-ID: <20241217171151.354550-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a zero value that is never read,
it is being re-assigned a new value from the return value from the
call to snd_soc_dapm_add_routes. The assignment is redundant and can
be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c8b7f78b02f0..710c278e4f36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2228,25 +2228,24 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	snd_soc_dapm_link_dai_widgets(card);
 	snd_soc_dapm_connect_dai_link_widgets(card);
 
 	ret = snd_soc_add_card_controls(card, card->controls,
 					card->num_controls);
 	if (ret < 0)
 		goto probe_end;
 
 	ret = snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 				      card->num_dapm_routes);
 	if (ret < 0) {
 		if (card->disable_route_checks) {
-			ret = 0;
 			dev_info(card->dev,
 				 "%s: disable_route_checks set, ignoring errors on add_routes\n",
 				 __func__);
 		} else {
 			dev_err(card->dev,
 				 "%s: snd_soc_dapm_add_routes failed: %d\n",
 				 __func__, ret);
 			goto probe_end;
 		}
 	}
 
 	ret = snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
-- 
2.45.2


