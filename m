Return-Path: <linux-kernel+bounces-225972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29806913898
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E8828205C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12C03AC1F;
	Sun, 23 Jun 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/4KQ8go"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9B27453
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126858; cv=none; b=HXNijFccFP7PUiu1Uff/Z7khXPqYvENLD5U9wzp4y93ocTmIzzsb+Nd39jeDwrdjzzhg2w+W3OdcDcLiuoSGKuUBSajz7pGudqevMaBnYY7wXtUKJXlHJiRX7PQabPItPzEYxROEQkwzDhk4/Bb/HlzjRncWWtL9XH6sgEuTlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126858; c=relaxed/simple;
	bh=BSN1FG/8g8BXDXDTjedq40cJnFrBuREudY/tMYsjNb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUuccLXhbFrDQa024q/O0PxDpwhpTng/SJ82Cpl3neckkN8OuJl5f/nS/k+n+ojlDLvcl5hcKdictger04bpCziirhSoWLSF8jwLuWUTzO4qs0HWhHHH38JjDX1E8UoExXY7AC63Ewv/sBIRb+mA2EvlYIJeRNyTJxJZEMUxjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/4KQ8go; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso47396921fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719126854; x=1719731654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv3RmqBzxRumknsNv7kNaxp5ef1fpM+tuKvMs4Mga4c=;
        b=Z/4KQ8goXEm93IxufypX+H12V1AjAuNyrbAZyLxwtZWfH1d0AbLQgZ68jGID4VboWE
         MTUBZrQ/gry97W/8CmQUTv7VL9HHCR9CD8KfewwqHEHs4czRSMVy7VRwQNp+ejf52ASn
         ukN4VyoV/cYLdYc6F9mnYZy9TOwK2ejbgCgBvZPwWdqzdV2LzcjnWwK7L5PYcdW6cOdn
         6YE4AsiYRLPx1Z7G0bqH3XUZRVTSm4OMvsq8pUW/5HreYGDnQ5bOLZ2fQci9U8tn8fDv
         ILCI4L7I/eP5okwgJq8xC5UhbHOMgXOl131JYkpl4I3Ix0+iICa5fS7JdLsUbeztFXtO
         R0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126854; x=1719731654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bv3RmqBzxRumknsNv7kNaxp5ef1fpM+tuKvMs4Mga4c=;
        b=wOfu3uK49gfyNGF5arF5LmusIfaBNMscCq+0VfdgvuNxIm8Fud4n1XdoIs/5Dn/kcz
         OqlBwgBm8ej75cFjn7ddhL1rsgaxkKbOBFMhgjBgsL6D9+ZQQ9QVPWCiVy9e9a8LS2Aq
         5yMjBHxd03DkvNCk54KijhN9znOqr7uWSQ74PWiaKyx6v0RXUlmlbTxKa71NrjXSYdpC
         ezULPfyGxWq1eXgJQI02ceE9zCrGJRqBcx/VNB3Ct5tyUw9GW0l8aYU7lvVI4uvVRwrp
         YasQZG7rkfP4St7F07SzloI7L/UPDaHuqC435sTQysvP8/v6MzoKJ6tjrHM8omNBpmuu
         sZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN212SqgqU8E4/PlbYABah+xeDJ0QkZ5sQD5sPcnnMLH3yLGpMXpkO2RCv7kr+EwWeUtTqnDcmWN23fiONjYFIWZ/c/JipKrwvb/12
X-Gm-Message-State: AOJu0YwRC/3OvviLJf8FTRAKJGEmSTQZoRdpmTmsGrdN4AekfXggOHLu
	kPytp9DdNZ0YnPTeZ39xbmzYwmyYgBk2wv7qZljWL2ftibop74Wz14Zrb6blukw=
X-Google-Smtp-Source: AGHT+IHVCwjM8471lU/ehMDgW/YT4M/SicFwOJ1D/s5IwFxGRJ9Q7jeIscRmJofRYLPSnsakpvTTBw==
X-Received: by 2002:a2e:86cf:0:b0:2ec:5a6e:7771 with SMTP id 38308e7fff4ca-2ec5b31d1b6mr11292671fa.37.1719126854458;
        Sun, 23 Jun 2024 00:14:14 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5b031208sm1886861fa.26.2024.06.23.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:14:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] drm/msm: make use of the HDMI connector infrastructure
Date: Sun, 23 Jun 2024 10:14:06 +0300
Message-Id: <171912674295.840248.12157846241927511158.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Jun 2024 16:22:57 +0300, Dmitry Baryshkov wrote:
> This patchset sits on top Maxime's HDMI connector patchset ([1]).
> 
> Currently this is an RFC exploring the interface between HDMI bridges
> and HDMI connector code. This has been lightly verified on the Qualcomm
> DB820c, which has native HDMI output. If this approach is considered to
> be acceptable, I'll finish MSM HDMI bridge conversion (reworking the
> Audio Infoframe code). Other bridges can follow the same approach (we
> have lt9611 / lt9611uxc / adv7511 on Qualcomm hardware).
> 
> [...]

Applied, thanks!

[4/9] drm/msm/hdmi: switch to atomic bridge callbacks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4fd10fa0b573
[6/9] drm/msm/hdmi: make use of the drm_connector_hdmi framework
      https://gitlab.freedesktop.org/lumag/msm/-/commit/aaa38235b5fe
[7/9] drm/msm/hdmi: get rid of hdmi_mode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/97d6442e8f9e
[8/9] drm/msm/hdmi: update HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
      https://gitlab.freedesktop.org/lumag/msm/-/commit/917921a20294
[9/9] drm/msm/hdmi: also send the SPD and HDMI Vendor Specific InfoFrames
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bf28d52a20b1

Per discussion on the mailing list, 5/9 is deferred.

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

