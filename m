Return-Path: <linux-kernel+bounces-576165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7CA70BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4083B8E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1219ABD8;
	Tue, 25 Mar 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpN3I45L"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637032F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937364; cv=none; b=TG3vjte6GYUl5hTzBR01ziHW7tFf+kljMy39UPUJiIhsc4iZFsWRPa7oNC3QW+pMStqWKpn/xW++bLFyYMIt29aQp6h/fhkILxyjGFrcmG3qtE5MVa93q2p3B6jnEK8OScWm3E6SHH491FZ8YXiO1JnsNiwEp9BPvT/7Myu/gr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937364; c=relaxed/simple;
	bh=xdUAEPlkjdFnId0CwibWv0kfo4J1OSdEA+5uuQwXCdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONyaUMg85QsaWYkHDDbrXZ3k33wkXWef407kXVc1zH9lN3B5dnD5QgLPNzfJidhoOcTAJmhfK3rSQRqUl7LiDxTzlsmNQiwo3cfyx6igc45Nr1HAqsOTHTY3Su+GAW7ESBkl+7eR9nw2T6SZOejTpAxu+cpuBqTPvyviscfZNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpN3I45L; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f8657f29so51260766d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742937361; x=1743542161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40K5pq7mYVh4VrEl8AnjijJbn+gIm8U/aSBOA3s0pZQ=;
        b=bpN3I45LAgyrNAnhX2Jv91V6WXy0XibqpFHgkygji+IwXAaAqUxm/ASkW5IJXgVKUW
         ZxY/mI87mbq+1MPb++6jzTC4z0vLu7h9hfOB1G5mxYbjYKF2zSdyXDb8CoRmWs8eZKfr
         43xZ91pLa0HMOgF+JKW72nZRW/Sut70+pGFmjgjB1WLlOZDpoQHXF4liGx3Vnd8b9rYN
         TJ0O6Mg9SMa5nuBlVMWGisilS7QfZoL5YoQjez9VWbZ9KdyvkokCJ77g42G1jDJ6oX84
         wLna/7tv7ehXqpot0ApPGXo5foerw7RlyV2XnakWtG7RleY6W3yuXDIOqBm3x3KUEErC
         2yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742937361; x=1743542161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40K5pq7mYVh4VrEl8AnjijJbn+gIm8U/aSBOA3s0pZQ=;
        b=LEnf6ZZSHPogFyjc5yi14IgZRu+4aYeLJA5Aj0eut7DEsRdbegi7K27p3FJH4YqdkP
         REuCZrwjtPeM2+ReS7Gajzc7xcPpXJ9BKPPOjfnTjD2lVRn5bIQ+IOQ3sqMRyk4m8tIO
         XTELXt8KesQn0fttYMJz/eGGnAC+3m1A7KtEbuJHxjqaRsdyhC6p5zZvx00A2eT8SlBz
         VVxY+hqh+BB78RfTbgTt53TX/RZSFHWyPyNgsVornTP5drXdnANk0Ws0mq71qrHTFzHB
         baAC0S81/rbjPcJd30fHNIhmhPOqnnZk2hX0h/uY35yvPwUD17Y3fNdXQJjOttMzpoUr
         H4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU63CpQ+9gmYCLn5uI8SEnA+GqtQBVZ26FhaGvflniw1lWVFO5dJviNn+W06EMMZCy56u4r9oakPaifz6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNu3F6yWodWhu7Gs41wffLXsTF7qAduCLHWsHmVzwIPPU9UCAi
	qkDWo9g1zCEgCRu4ZGjIeMY9Fh9NL5zMEMDUy2qFIQBqnZs6luD9
X-Gm-Gg: ASbGncvcoDZrixrMNslXd20H2Wfxuz+ihKWGOM6Q6Etk16n7TcO3wyTUkMn+w7x7Jtr
	lxEfn6YJqfXgDCNjVQAsJu3gkhCRdVOD+wnHWFLvlCAjpkyWK6olO8/yzdSWFfbV/6c2e647Rw5
	sHI/cAKNRATMa2AlB5uST6BUkoM+qgvF+MM6xggPBoqVJe9NftSyPMgwpTFN121XTg6jaNxpzDu
	ZMTdZG7MiJTXZZ4/MbBhdhj7m6nK5PcB/C6uj2Uh5urfFf4OtOwIS0fpoptXANPu6PgdMto1H0S
	SZDP7zM9VMW8FDXGa4u7+VJIqiKR5ZIbWtxK/r8m2wDbL1VqsdywAFor4+dX9MbxZeBS6BmXOZa
	bHB8Qs84nbgn9ambWWRk=
X-Google-Smtp-Source: AGHT+IHZN0DvqR3zf6bcLPm5iIDPZ4bv5imEYKlo5WLdo3X0XPq9mZKrg6GEYfXA8J0c5SD86F7baA==
X-Received: by 2002:ad4:5d42:0:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6eb3f1a7037mr239109526d6.0.1742937360994;
        Tue, 25 Mar 2025 14:16:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5944sm59648256d6.75.2025.03.25.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:16:00 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH 2/3] ASoC: amd: use new ACP dev names for DAI links
Date: Tue, 25 Mar 2025 17:15:45 -0400
Message-ID: <20250325211545.2099169-1-bradynorander@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old names used automatic platform device ids, which means they could
change. Use the new device names which will never change.

Depends on patch: drm/amdgpu: use static ids for ACP platform devs [1]

[1] https://lore.kernel.org/all/20250325210517.2097188-1-bradynorander@gmail.com/

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 8 ++++----
 sound/soc/amd/acp-es8336.c           | 4 ++--
 sound/soc/amd/acp-rt5645.c           | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 02b04f355ca6..42aa009c4e13 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -517,11 +517,11 @@ static const struct snd_soc_ops cz_rt5682_dmic1_cap_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(designware2,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2")));
 SND_SOC_DAILINK_DEF(designware3,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.3.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.3")));
 
 SND_SOC_DAILINK_DEF(dlgs,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-DLGS7219:00", "da7219-hifi")));
@@ -533,7 +533,7 @@ SND_SOC_DAILINK_DEF(adau,
 	DAILINK_COMP_ARRAY(COMP_CODEC("ADAU7002:00", "adau7002-hifi")));
 
 SND_SOC_DAILINK_DEF(platform,
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index 0193b3eae7a6..b16dde0e2987 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -137,11 +137,11 @@ static const struct snd_soc_ops st_es8336_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-		    DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+		    DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(codec,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ESSX8336:00", "ES8316 HiFi")));
 SND_SOC_DAILINK_DEF(platform,
-		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.1.auto")));
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link st_dai_es8336[] = {
 	{
diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index 72ddad24dbda..11d373169380 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -108,15 +108,15 @@ static const struct snd_soc_ops cz_aif1_ops = {
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));
 SND_SOC_DAILINK_DEF(designware2,
-	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2")));
 
 SND_SOC_DAILINK_DEF(codec,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5650:00", "rt5645-aif1")));
 
 SND_SOC_DAILINK_DEF(platform,
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0")));
 
 static struct snd_soc_dai_link cz_dai_rt5650[] = {
 	{
-- 
2.49.0


