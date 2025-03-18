Return-Path: <linux-kernel+bounces-565628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFCA66C45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E2B421A61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2347E9;
	Tue, 18 Mar 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7z9kbBL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98266198823
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283707; cv=none; b=Jz4h6C0zF7Yh13w+Wfs5KPeeQbn+sXyxpBvTi9OoHmcsi/tVKNO699iVHLnBi8tST4+raUBc7ImTkNs6ozxtCMt6TTpWb94i3bg6Hw9rOHeJ5LTdst0FXgHhjbBPdI4xhYXawNj2ie3tZb+3RF7Z+orXuTtRMvpPXVy1sCeM6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283707; c=relaxed/simple;
	bh=O9jZcWIWmMwWgw3SIuenwP/maVKbFbUsn3EZOj/MOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD6rlKMURkTvs8jHWv5lhYTJrXPZKOa+498vkg7adf0VLf+ucz7u1iaj/Wb2cl+AcsAAx1dGgMuLEEeGx/fHBjqroDYq4HFRqCFhtXCxuUHWf+J0ro6sh9aSYlbLIRL9eP+Z15LwBzlYyrsU6ywVL2y7JVCKNiOpFhkHMW/c1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7z9kbBL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so100285805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283705; x=1742888505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVZR04S+QbsB8ngo9JOY80Ix4bk7+hFvRXCVeHlbQmA=;
        b=b7z9kbBLUhVtZkdaLuc9mAF6k5D7oP3TalrtCa8yKSHdw2IFlgrzGJ8TK1zAz2V+Ux
         JoNhS6YOOmdF0KGH8kmkFj7UztnMKyEoPb79FczyvrQO2+/4HhD70rNEl4idwSt0CY66
         CfbhgOkZkpJx7OcVRtFkrGtysXbxXq3pqUSGYMDe0Nziio1R7O0IkOzcr3+kMYAYLjLD
         ZjaZ5wrTiSIKcpKumP3HuLBtiwKxzo8Q8uqLU7c2tKW+aPZkYLqaMHRQy98gHDu+K9Pf
         WIHY900okWqps3a0Y3U5rdMymcqwB4Vb0cf+XKJQk/MFN+G8tC58jnCx5Xg9KdmLoE9M
         kzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283705; x=1742888505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVZR04S+QbsB8ngo9JOY80Ix4bk7+hFvRXCVeHlbQmA=;
        b=QwFwdhcbiBMHnidxoK7scUaR2t9/lULGlCdNQGq7m3MphNXRS921vMGneb4h/HR3cZ
         pBCUDRMxNjHDq3eMXl60Ml4pv+jMbLlfFQ4g8Y94JqZGIEsRpe+GovDP8gh5nKspGDZ1
         8bkDZNz14wh85O3n3G24+0R/uHa//9J0Q6kGldBSKBjxVRyxUTbmepW5Ksspcwuu/ccS
         5coJH5qDBpHBco7xviNns6bClNqQoM29a8bfIKiT3BFXw4QvD4Kncsrzkwum7jIO9AYt
         4cJOivvqaZuA1rJe1ONMrB9NvpdPfase2Chqft1xIQLxJZOcvC7l6cT8bL6O3pXOkvMZ
         5tHg==
X-Forwarded-Encrypted: i=1; AJvYcCWw9ZfHTk3i68FldrLtxFGj7Jk9g3ounmySqfGHDiJ5+lbm8kJ6lonM7azPS7o3LipkNHotNQFZF9dUN1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPj2eMVbMCWWDRCekQudw8/BTnz6q24/SI2V2DhQLaz993Yfg
	KikVxZf0TvfsN4RVAWPPtZupg0LXJl57zyXcgnjJN7/m9fAXV/l3x8pPukUzZlZFB1HkEK6E/T4
	=
X-Gm-Gg: ASbGncsKG/bVPXFBS2hqT6g4SxFwu453G6w2vU2CVXoq0fLvRMKl0QrRxqmGDp7ZssN
	wFZb5uNT0qeZAt3bZZWEA9fWGBYdQPoug/6WOq4yMpo+U9NkDedggH35jDzcYNakXDXkATRFgkw
	jOmkrIz/IT9be6n8Fvtt6xyRajXHYXCgHYHeVNzqRUSSLwKA1Oe854h5XsfqCmK8wVaimcBGwdX
	q+h7iwbDRkgxzRJbhQbRT/maJpI+P9Ig+oDy0edJ5j7hMIdYj5x3sCgsJA6D023bteGjMRP1XhP
	exikZ/jm9vxS1KYWpbseheP1tXNOD3gLut/WCNvHRhnPvF5DtYwhFfzk
X-Google-Smtp-Source: AGHT+IFyXEOBiMlUSN5i5N/Hw/HWhnWZVCQ3Gx+hf6RlAak5McTqA6i5CzSdroh1zfVKpZgEjUe7mA==
X-Received: by 2002:a05:6a00:4f82:b0:736:3c2f:acdd with SMTP id d2e1a72fcca58-737223b8ee6mr19051900b3a.14.1742283704908;
        Tue, 18 Mar 2025 00:41:44 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73766322e03sm151481b3a.99.2025.03.18.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:41:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:11:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 0/4] QPIC v2 fixes for SDX75
Message-ID: <20250318074140.yujrwgq743oqx5du@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-1-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:02PM +0530, Md Sadre Alam wrote:

Nothing in the cover letter to describe the series other than the changelog?

Btw, the driver has been broken for almost 9 releases and the fix series is
pending for 4 months. This tells a lot about the commitment to fix the bugs :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

