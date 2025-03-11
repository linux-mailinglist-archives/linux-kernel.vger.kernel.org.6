Return-Path: <linux-kernel+bounces-556476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E0A5CA54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B977A58DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7725F782;
	Tue, 11 Mar 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBAXtP3x"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5E25D8F9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709315; cv=none; b=cXY+uupmyfd6QqMywQo0rXCpTEHA7VwZLbBX82VQYT5d+kS5Xa2voQdfJcm5LtgpUWGraXwZm47z6KBlG5s+s/zbcCORBc60JQ+vn/Udbu6xIox3OBCE5aV0pQB5qnyJoXIpY4nMbehvkGhGQstHuZ9bVTzhaEq5Ltz7QbflTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709315; c=relaxed/simple;
	bh=vvR37tHe7cyHVxHmE1PSmfJx0N0SOaT219U/VDaoufQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLn0iSckkm1XB8DXW7v+f8mLCu69y3mO8kN86xu0nWm6H1wy6ues87WQwA/RCcMSYbbJ9cwf3CWd6HFz/x5IJbYQ+ap6Rbjq0PreXpYdSze6htOY94y+/1ApgyvpG59UcUeXR1Ygtme6qmpZdr18pjG5XMJAqFw3taTux05aNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBAXtP3x; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so60441411fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709312; x=1742314112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GV9BiiwCj0KjOF54Bg3Xs/+kHqJ8FRa+RX/vBXVgyfA=;
        b=uBAXtP3xVF4X0qYK/t7HpauVVlUPUx9eB4CNtKMjeW31AmE6gTCHJeTAv042yLGCcQ
         fVolKHnY6xYSf8DBlevb9vVhRaOpPVBpiDqyS8qQgiZpQLire7TvxW+6UaTka69pBoI3
         vA3oOI6E7jmyaiDQttfm9QFPobfsDYIlf41Ldm3TX4vTa0t/SnNksiuF8bMH7kJCsDAe
         zIMOLtm3dLZ9ke6VhMDmmPMJXOQLWtLFeI7u91zuXj3H3JKnogd4QpSPhchvSSkVr75A
         quQ2FxS8R5hv9I/JoZCZMM6T6ti+ZiEAa8zfYMeHwYu9p1aeE4BBvWaOXM/R7vYWh4Uu
         PnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709312; x=1742314112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV9BiiwCj0KjOF54Bg3Xs/+kHqJ8FRa+RX/vBXVgyfA=;
        b=RlYx87l4INXhB/N52DbWsjvkvX6foTw3eReur4kUfL3YK0YBvcWjAzOklLW7Ke+bhy
         naq2b2gn9p+Zmc1e032DVVPY7+Oa+SVEAdl5gwlzGbG6HpHYu2KA/PRbcfEksW4wIjkZ
         OixUd9SeFw+csokTX+s/sOoxd8f6YQAdco5iuN1NmmjgKWYjJNqq1HfJ26Q8t0oVo8Ew
         RIQHvi3YYw0ETcgP0xgAk/EthqqScuv9EGNcyScTEyD4A6kxR0rXpWvrzx5QbGCjafbx
         d3gsn2N3WNq7Ggy1/cae3BaTxtCYucUtnB+DaDmKHM45bnYW7RpZdD/qusLS5wRBVu/r
         9Arw==
X-Forwarded-Encrypted: i=1; AJvYcCXOLEfbXYFN92KdpBsJ1QywyphqbCPpeMjM6ScTA1/DMofdW3xnDsI9zJNEmghp/DFOAoOcOrYs/8XdDTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKS/4CikQLp68ylH+bVV9e2AvI+d1a2JWKYgeb4r/oD1JVmYjt
	i+CjU1TjQ5TDzEwqYXSCXzJxNx5XefQTB4BZnQ0F8WsBRERD8NYivMHjcW1a9AA=
X-Gm-Gg: ASbGncu7HGBrDQH5JKZoy92wPLfE+65WH2goEPcMKfmF87j6CwLuhIqNerQD1mGZbq/
	373aYA6Vdu8guQee+x3fYyirBVGExsiUBchXWaIvKBHGmd/8MZru//pNHoevt3v8oUkSipT9OoV
	BmrLQtmjpoqv25O1aSSNfF4ZOLApMI1L+ZxWneDhoVTNUykqtPUKRu8Xi6F5BasYZeLKWc01nRU
	8vDDAToBg0kcJPRVPkbIcVzkpvGYLm0nsvfGhhILoEKyQjEBbDV6oOkDrBk5ckWl4fIP3gB1Yx9
	KzeeFuJUdnXfrgg5ZV5+GnpU29NDfs2TmJY+Ho5RuI3PscmylCAm4YtjEJkKj4RkYTG19pJHxzS
	r5/ZVLaPbs3iZW+Bfzvk=
X-Google-Smtp-Source: AGHT+IHcDSRBowB0gIghFW6AqPZ/rRpdWPKOTwHZTyDRWmZvHuECIB/VUu27j6hMEwmcrwfl6a4OUw==
X-Received: by 2002:a2e:be13:0:b0:30b:9813:afe1 with SMTP id 38308e7fff4ca-30bf45ec43amr74624571fa.25.1741709311824;
        Tue, 11 Mar 2025 09:08:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PM: s2idle: A couple of minor lock-simplifications
Date: Tue, 11 Mar 2025 17:08:21 +0100
Message-ID: <20250311160827.1129643-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on s2idle a few things caught my attention when looking
closer in the code in the s2idle_enter(), in regards to locks. These two
patches tries to improve the situation a bit.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  PM: s2idle: Drop redundant locks when entering s2idle
  PM: s2idle: Extend comment in s2idle_enter()

 kernel/power/suspend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0


