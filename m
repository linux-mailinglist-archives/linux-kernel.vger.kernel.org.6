Return-Path: <linux-kernel+bounces-541116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96065A4B8A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31B189243A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684911E9B3C;
	Mon,  3 Mar 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qw4KkNK3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB81C5D76
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989006; cv=none; b=PvEED4NPiT8y/J+WLwSbCAiWmG+I/bWk8T10TnFRzu57NuAARYlLf+duKSEUeNtfCUolrNFEFxkhgQrWWQlHHtvlOL9yYZHTY/lrCXkXApFCdOCT5xeVvyZ/dFU5NWzx/QGi4q/+OiOrhxL6CUo4raJv+JqTs0AVJmDZvAU/U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989006; c=relaxed/simple;
	bh=jXmABgKlTV2rT+eRZ9rrvS2Qs32wSTbnbdHdyY3i1zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYL2oI/0nawxXT/vT0QDJVot3EzXRyLMf7w0Cl6oW9O7ZaozLuZE7qGeQuLZal/Tn+qfJDK53RX4ClcwZCt85w0cjzTi7sp0lueVupj0tQOz/i2WBM6+1Wwh8Ax43BcNR/2RnKACC+QuVPBwX0JzYi9XuV4DjOlND6Dqh/vp6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qw4KkNK3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so931622166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740989003; x=1741593803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/kOfm+NCxRWU3KiubFOyYUQosuGisbp/XscJHpDiwI=;
        b=qw4KkNK39YKUf3BeGHAcfRXZoWAhW4zvxMF/3RstXU/gmsOdO5I1kxey0L9liwXCNt
         3klQAZSP5No7NUOvzdi4KdhZjXTFD7+cn19gSdJi/hA46S5UmrTjSxjL9RS9b2q/a7KV
         vEbcW32gK0Gm9nA+bvBH2v8u0wlB3Jw6w0QlO4nXHFyY6tRlCXYmCZwvtDGWRzaSa9JS
         yN+rOjDqxnvjRXv3TommK6PeSaDOHW60d3vigc/Qoq6DC6eP1/07J8r3aOQDBxN6CfVb
         8TaDnJh3Mg4i3ik3V4AtTZr3Ne89cosBKIPxkFUfkf119BKRkLBHoJcv8RTiZPI7s2Lx
         rTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989003; x=1741593803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/kOfm+NCxRWU3KiubFOyYUQosuGisbp/XscJHpDiwI=;
        b=UwIvfXMZ2tZrWZmlAIgfn/bbquF/t8NGx7jfz12f//rL9epG59oLH3lyg1sT4QLm6X
         3nA0/kx9MLWO+HmWpLhcvxGa8NFkkjWfdvmChxROt4XspZzXh4fzUkuYro1YwKI6SuMe
         sl+X9WH4DretYe7a5x4MTPq/r3zWty6033CpLPE7vspo81gNDHfk9B+ko+zRyctF9GOk
         PVukd10Y1Sc9XVAZhSQJgN46GHxqJorMvL1ykbu7gdQ+1/ikH2Iu6VQCgljZ80EHC7rT
         p9iRpB1XcrWuAkYPSaiCm+Y1N+iahGhJ6Bw7xIsSdf9hslodtxKQJv707XfI+oUA9gde
         U8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZYuKCgKIJQEvYspRJhbuIYvGz0NDwLgflu+UW+NHTvVPmnQLYKEd1JkSYWSQB+5RYVjHGhM6Yg7+Ero=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecQ+hTiHFkBPiVKON2rnH28ASxednsxejSps0Wm4aSI4rFlxa
	qbDYpy/FS47dfqqwZDOUsTcR8OES5ODV2bLj3jqC1Vra63bFnzrqx+X074Nnvok=
X-Gm-Gg: ASbGnctu6ltdB8164D5PxQ9gtBcQy/vyhCAzsRWF3dO9TMqcKR1AOFuSaaBRFVu9TBG
	EcNEgqb9quoy0EvNv5paWPpf4bXMIEzR3rpbQLfk9jBr9ex0X6w6p6ogBQBoLCLkNgwqWW2/bsx
	aNj8TUeOLlO8cROYUF/hgoTuyOdOvzvnNnC2rsllDMh5v7ejFNb2cviO3uruORlW5p933AL8COV
	q3ck/o9IxxSe7L5vvvumsGK9ZLqktsuKrDMZeJByxAKn7n6kLmEbf9EwfTaOMi7gBJQaowi4jCh
	CwquPzPItT4JjgkKww40TWPj8jB8YEZbJKnvVmPItDHiMkaO8g==
X-Google-Smtp-Source: AGHT+IHSJwyoyFbSkRa1UEg1HQ8PZPp0oWijLI/xxUyJmjC4df5Zae4YdAsynhyaSb+1Hid60bmPNw==
X-Received: by 2002:a17:907:7f26:b0:ab7:f853:1445 with SMTP id a640c23a62f3a-abf26883e80mr1335907866b.26.1740989002624;
        Mon, 03 Mar 2025 00:03:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ee730sm764757766b.104.2025.03.03.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:03:22 -0800 (PST)
Date: Mon, 3 Mar 2025 11:03:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 3/7] firmware: arm_scmi: imx: Add i.MX95 LMM protocol
Message-ID: <2c8e8e93-4ce7-4260-94bd-eabba0b7732d@stanley.mountain>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
 <20250303-imx-lmm-cpu-v3-3-7695f6f61cfc@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-imx-lmm-cpu-v3-3-7695f6f61cfc@nxp.com>

On Mon, Mar 03, 2025 at 10:53:24AM +0800, Peng Fan (OSS) wrote:
> +static int scmi_imx_lmm_attributes(const struct scmi_protocol_handle *ph,
> +				   u32 lmid, struct scmi_imx_lmm_info *info)
> +{
> +	struct scmi_msg_imx_lmm_attributes_out *out;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_ATTRIBUTES, sizeof(u32), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(lmid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		info->lmid = le32_to_cpu(out->lmid);
> +		info->state = le32_to_cpu(out->state);
> +		info->errstatus = le32_to_cpu(out->errstatus);
> +		strscpy(info->name, out->name);
> +		dev_dbg(ph->dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
> +			info->lmid, out->name);

Print info->name instead of out->name.

> +	} else {
> +		dev_err(ph->dev, "i.MX LMM: Failed to get info of Logical Machine(%u)\n", lmid);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}

regards,
dan carpenter


