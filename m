Return-Path: <linux-kernel+bounces-334502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8097D812
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A87B246A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316917DE06;
	Fri, 20 Sep 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="gikJJ6bJ";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Lg6ea0ra"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DA11CA9;
	Fri, 20 Sep 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848707; cv=pass; b=W51zr+ItRyzd0ZjOstVt7EW1eR+/06Lk8VRLlkMpne+Wkl0DC6zNX1QLtxDOa42Dd76oLcn6h+3VQNSvEvVvIj/pBAvj6qagNW0LxTfbq/lvD2F9VjSAvcmpP61A8vY9Ly1qMaGaq9TSWgs8V6FpYsYLp9gKE7nHCkLrp9eJskU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848707; c=relaxed/simple;
	bh=r6pA/RL8gVFFAybakpPI8GmmDxoJqi/6peyLeguArPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N+7BJD61nnWJYPIw0/c/eedqW8X9BZ2SbyqyNGtCMUSzmq8oo1Mkpfv3np/v10U8N6d9yTVK0uyZqhjNEblX+u3fN4CZhkq/HZBvCvSmP9SUFPc/OOFAUfpM/AOb85wNFSqKqGeBFBDmi41VCoX6y5q4CJv9JbymlohlfNKlnX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=gikJJ6bJ; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Lg6ea0ra; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1726847976; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aNtX6Uy6W/w0p3DzLbbrNaN9sL1N2m26CRc9gmD2+ubt3uvUugUlHSC5Exro8Wb+G7
    CiGjhw+SFoV9M4hBdEkPBqclWv01xG7xPCv2yfhkLtyRLQejxvFGN5Is7aKzlocGPfrO
    cxS4cn6Dlj68Dbzg+tnBhqRo2U1yL3DAeAQw9pDoYaZiAdL7k1ObRpYk3JoEZAe6c44V
    d38iZmDCCHZsqRmIcichBNlHOlpK/Wwu4lU+6yw8gwJqxxrxkMhzR78J9OtBa02IxTE9
    /trB/AML/6tPa/cyfuURob2jT81yzD8v4Ll5lEdJFvqQcyMgkNEdUgM729jxOKhmYmJh
    YM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1726847976;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f8jxp8GbOrEV3KKDbHxpvkXMrzqQE3AMJeZLg5mk+AA=;
    b=EwT9/dCqLK5+zUaAIBBq8zZco2ESh9Pq3NqOSxpOlKjk5i4Zf7ZHFda3Nxn8TFvszZ
    Lj1y6TqJaGVBarvi5x2gJTcAmtQ/mPdYm6PGCDJ/UZJ79bQTqssJmuo4rYe/GmMsDocB
    Kg7VW3mSOUnPye1oskG6njm16f/4K9bcBNVp03lwn7mkrX1GRJWXFGcSrWvgmmEEtQHA
    nT+0ZKkdhM6LMSiYsdPssdbYthfbUBlPVLJ+fnjWfeg0fojU0fuV8c3Ps7eaqIT1q2RD
    dVMEkF57/qNSVvemajvNfS5Z0FanFsj8EG56ETaRxDgwUNtK9QFUTSJpikITTlvQmJEV
    rUEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1726847976;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f8jxp8GbOrEV3KKDbHxpvkXMrzqQE3AMJeZLg5mk+AA=;
    b=gikJJ6bJC4znKeUpHOkKcvLOQYJyDb+MAkng0DogD7hRusPZZeK04KW/Bp0VXIUxoF
    XnAEwudV4AOLIXWMqYJ0KpvAdIlsXV6hfAlKY79efuDSK4PyBRqSM00uKwwL3uIemD0l
    ljkwTLwBWHiTGi4mobXKR2mL9VLl9X583E5KgDh0KZYTHlw2TZ4603e9uLSYl0/MzRwf
    FgyPRYGEITlXj1wnLGCSlreRCSSRZededPceDnfYsTbyyT8QiwWCkdgKJfyKE5c/bXV3
    Z7sSnsMdRSNvH/hU1GA1rMQP7O73965vIB4TvSOBGvm8D8d9HmAb1TBf9Jl26DT/Akxi
    c/YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1726847976;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f8jxp8GbOrEV3KKDbHxpvkXMrzqQE3AMJeZLg5mk+AA=;
    b=Lg6ea0raIql8JWDYzsrMO0ftb5qSzcUpgzuei/2LNuvYovnF+CxTHY5k4l/zKX1jC4
    Tb6yKpoGWpuukoDBLMBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeDsZ"
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 51.2.7 DYNA|AUTH)
    with ESMTPSA id Qd0dc208KFxaJNJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Sep 2024 17:59:36 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	risca@dalakolonin.se,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ASoC: topology: fix stack corruption by code unification for creating standalone and widget controls
Date: Fri, 20 Sep 2024 17:59:33 +0200
Message-ID: <7eca678fa7faa9e160b998192e87220de81315c8.1726847965.git.hns@goldelico.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

After finding kernel crashes on omap4/5 aess on PandaES and OMAP5UEVM like

[   46.367041] Unable to handle kernel execution of memory at virtual address f164d95c when execute

a bisect did initially hint at commit 8f2942b9198c9 ("ASoC: topology: Unify
code for creating standalone and widget enum control")

Deeper analysis shows a bug in two of the three "ASoC: topology: Unify code"
patches. There, a variable is initialized to point into the struct snd_kcontrol_new
on stack instead of the newly devm_kzalloc'ed memory.

Hence, initialization through struct soc_mixer_control or struct soc_bytes_ext
members overwrites stack instead of the intended target address, leading to
the observed kernel crashes.

Fixes: 8f2942b9198c ("ASoC: topology: Unify code for creating standalone and widget enum control")
Fixes: 4654ca7cc8d6 ("ASoC: topology: Unify code for creating standalone and widget mixer control").
Fixes: 0867278200f7 ("ASoC: topology: Unify code for creating standalone and widget bytes control").
Tested-by: risca@dalakolonin.se
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    There seems to be another weakness of all three patches. The initialization
    of the kc.private_value is now done after calling soc_tplg_control_load()
    which may pass the incompletely initialized control down to some control_load()
    operation (if tplg->ops are defined).
    
    Since this feature is not used by the omap4/5 aess subsystem drivers it is
    not taken care of by this fix.
    
    Another general observation with this code (not related to these patches here)
    is that it does not appear to be 64 bit address safe since private_value of
    struct snd_kcontrol_new is 'unsigned long' [1] but used to store a pointer.
    
    This is fine on omap4/5 since they are 32 bit machines with 32 bit address
    range. A problem would be a machine with 32 bit unsigned long and >32 bit
    addresses.
    
    [1] According to my research this definition was done before Linux-2.6.12-rc2

 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index af5d42b57be7e..3d82570293b29 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -889,7 +889,7 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, size_t size)
 		return ret;
 
 	/* register dynamic object */
-	sbe = (struct soc_bytes_ext *)&kc.private_value;
+	sbe = (struct soc_bytes_ext *)kc.private_value;
 
 	INIT_LIST_HEAD(&sbe->dobj.list);
 	sbe->dobj.type = SND_SOC_DOBJ_BYTES;
@@ -923,7 +923,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, size_t size)
 		return ret;
 
 	/* register dynamic object */
-	sm = (struct soc_mixer_control *)&kc.private_value;
+	sm = (struct soc_mixer_control *)kc.private_value;
 
 	INIT_LIST_HEAD(&sm->dobj.list);
 	sm->dobj.type = SND_SOC_DOBJ_MIXER;
-- 
2.44.0


