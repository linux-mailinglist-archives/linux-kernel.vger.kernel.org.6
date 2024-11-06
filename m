Return-Path: <linux-kernel+bounces-397334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567399BDAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441721F24188
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436981552E3;
	Wed,  6 Nov 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG+n9WYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC5142E86;
	Wed,  6 Nov 2024 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854433; cv=none; b=FkMnjQ51eEyfPlIhilkghR9ExlZcRyUI/ulcy3E37+uZLyr/MOMVgCUYfF5DcrpcWHDD2SuiRWecYuF3oOVpoxbhDgBrBliMwoyBRhR58r2imNIOT2/pMYrC7iGO7FEAxjlqE1NlrRchkYLn82HCc0DofTIYX1XuWPf3feFYu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854433; c=relaxed/simple;
	bh=5+9PnptEWAUvLGJXI05VuDF7HPRuhwgo8QQsff/68SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1dCiWHoRbNL2HgErKhWvIgRour951KXK5DnZY0ez3Q/7oktcBfTuUVnleAXjf+03wavOjiYvPFWIcK+MVRhX2ChIHZraijm4DziXqQ9kk7TY2ifPyiQRycg0jV/euFE9P0yjDA0/zOutNWK8SrhYA3GHDHk0VvnHUmzohbjl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG+n9WYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C50BC4CEDD;
	Wed,  6 Nov 2024 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730854433;
	bh=5+9PnptEWAUvLGJXI05VuDF7HPRuhwgo8QQsff/68SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sG+n9WYyfglBCA6kZPg5XGRlbCQZohvIU/S/UbhmNn0N8JUBYZmOPnlczS6ArLCW7
	 MECvn62VdbBjzfGHTRmmaBimUg8Eg/bfkoCPByCEzJoo93nUI1+qgOP8qjSij+POXJ
	 9ve2a57xwl3m0Dv4ma7RSQCIIQPOqyl7jiEzNkCe6iUqNbK9HeObb5vqq2gEvrHn7k
	 IXn8W5pSl9cKWdBXJBZ16doTefPGHoLSa5RU/+FK73ObUiCpSnpCZjxmqplo2Ebve7
	 0+F4NUDNHLlp2wH4SqvTr0bHily7MoW24nL/A7yRrYBh3Nzfl3R58I+vcoTHksW/Bt
	 k9CIuiDezZx/Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	=?UTF-8?q?Kamil=20Go=C5=82da?= <kamil.golda@protonmail.com>
Subject: Re: [PATCH] clk: qcom: Make GCC_6125 depend on QCOM_GDSC
Date: Tue,  5 Nov 2024 16:53:43 -0800
Message-ID: <173085441659.26510.9677618815365313460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241003-topic-6125kconfig-v1-1-f5e1efbff07c@quicinc.com>
References: <20241003-topic-6125kconfig-v1-1-f5e1efbff07c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Oct 2024 01:16:27 +0200, Konrad Dybcio wrote:
> Like all other non-ancient Qualcomm clock drivers, QCOM_GDSC is
> required, as the GCC driver defines and instantiates a bunch of GDSCs.
> 
> Add the missing dependency.
> 
> 

Applied, thanks!

[1/1] clk: qcom: Make GCC_6125 depend on QCOM_GDSC
      commit: 04bad0c91743c8f3753c35750ffe4ddb1bf22489

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

