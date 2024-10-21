Return-Path: <linux-kernel+bounces-374282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3A9A67EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B9A1F22679
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615F1F80AF;
	Mon, 21 Oct 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdi4SvD3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29381F6694
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513072; cv=none; b=ICMqaQ8w+x3zbsBMBmg8BDrngvGZSKbMgfzJptRh/1bxB1TZ+OLXYjhINa9m4aD47INs6qXy9SFCK+hdEoIRQ6nl1Z1z9EToi/mrXTWhtgQ6F1oMTKpeQ1ztM550psYr2DNbK7vTYYWjxCpsxzLv2SJcipl0rzGeMGQuzXWMLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513072; c=relaxed/simple;
	bh=Bk2N6mWyb9VwBpvSkQFvVLAPHcEmjUsvtHxjFnzzpz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL2nrVLf15wYfX4olXK6eBgrG1nSRtNkYpaXHWqQ/6iDpQUm9LlwZyIZsg19mpDvYLXsGkP0weKzCwPiQY2kAnub0hR5izwncLsh1UBETT0/zOJrAcieWli2NycHVXvCyYxGWrg3g9CfpBDvFLL+cFw3i6jjbHGCmE3x+/uf8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdi4SvD3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8586b53so4575816e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729513069; x=1730117869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZF/QY6lgKCZozlrE12q9Y4uQ6tVQUtMhzEdEOTrjAI=;
        b=gdi4SvD3pazS2fj5ciMrEX7E5+IasHIartaHPAKAKvjtrt4X+eDO3cniZL+Dmzra2w
         SfliB7g6CrX0mDQ+0cD38r/0iRLV7G3WOcf0UU/IEiKLHEASPgA4Lw/8Qr7Rf3K1Z7nS
         4r64ej5kguRbDRTLRF0VooRiQT49F22LCQ2Mk3TKom1762tRmeqcjVCgIZ4ygBG1mXJj
         rHsouymgHmHTzS9n0MpSLUuRj4k91dBm+sYaLHX13LP6Rr4YWKzyTvB2xvYdYGX+Y5qW
         8fWZ2QdH51W0l9E3I2EiLPTTnIF/Cg+BzgjFkEiWGOEFnY15b1XpMtBIZ1XKrNGLJuE+
         VoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513069; x=1730117869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZF/QY6lgKCZozlrE12q9Y4uQ6tVQUtMhzEdEOTrjAI=;
        b=oE9xbXDIys7ZtAw10YdBvrcwWFL+EF1m5BQQTL0M5bX5G//ShzBUhPJLekjzn5qYlf
         Z/c0BcZnhQ2cPl0Nklg5/wY1SXSkiXeoMjq6YYY6EHMx3ub2dS03sZ/OX87g7opb3uGD
         sro2YYSzc9SLQABjquh+hK04yEjeiWdpJB56phqsjUHrpmpG7MvE7B8pSHl5ohuLy0DG
         zqfvMfMxmDOeTODkXmqB0u2eQKi6//9IEu7BSmrhiWzleMJf9c4niuZK/hfsPV8EBxwR
         Ysfq4GfdewpoRFqkHB8Sdai7+NNDuzYSs6k3sizixyD4DCPCNLelkDHGFTURs3w/4VF/
         Z56g==
X-Forwarded-Encrypted: i=1; AJvYcCXUWnjRimmGHL3ODHO5LoBOC7604MIFHRe5wkM6Ft85GEPw1H1colnwEWfFOxVx+5C7owG2fTVzyNCl9+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzilXmjZc1+qEe45wxFbF+vqHTEtun/lXP5hYUtzZbwS871WlSO
	UAZJZXRM4Hx7Lu4d9XYmCHxkgH+y8TM29Aq39SzpCmyzzVv8Go+tLrR0G3EeLIw=
X-Google-Smtp-Source: AGHT+IEp7b9dHlvPptGyKtr826kptA0YP++LFaH82xrCED22x7jik+ibY/CFrIq5TZveCAvHnhMo+A==
X-Received: by 2002:a05:6512:1584:b0:539:f84d:bee1 with SMTP id 2adb3069b0e04-53a0c6dbb2amr5752157e87.17.1729513068790;
        Mon, 21 Oct 2024 05:17:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431454sm464210e87.212.2024.10.21.05.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:17:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>,
	Rajesh Yadav <ryadav@codeaurora.org>,
	Archit Taneja <architt@codeaurora.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Chandan Uddaraju <chandanu@codeaurora.org>
Subject: Re: [PATCH 0/3] drm/msm/dpu: catalog fixes for SDM845 / MSM8998
Date: Mon, 21 Oct 2024 15:17:38 +0300
Message-Id: <172950935861.2053501.17445989059295810521.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
References: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 05 Sep 2024 06:26:12 +0300, Dmitry Baryshkov wrote:
> Drop two extra blocks that sneaked into SDM845 and MSM8998 catalog
> declarations.
> 
> 

Applied, thanks!

[1/3] drm/msm/dpu: on SDM845 move DSPP_3 to LM_5 block
      https://gitlab.freedesktop.org/lumag/msm/-/commit/768a272d5357
[2/3] drm/msm/dpu: drop LM_3 / LM_4 on SDM845
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d39271061d67
[3/3] drm/msm/dpu: drop LM_3 / LM_4 on MSM8998
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c59afe50773d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

