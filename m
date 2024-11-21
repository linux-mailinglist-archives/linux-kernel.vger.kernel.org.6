Return-Path: <linux-kernel+bounces-417055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4A9D4E59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4497FB22FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2F1DB527;
	Thu, 21 Nov 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg2ElmpA"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA1DB54B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198298; cv=none; b=tmjUXnn9b2wf0vvXW42JhOQ0rAWoL/oV09I6HttolSV5nldNw7qQuA+yUWLKnZbCcSlPb/+gzJNZfFkmqMYToAu1lfGzPj9OiR0r2oVlVgYM5Huyox6kZXG8P3GvzVbnt6wHs6opV6+21S9nhuRIgs4d+6sobRISaVKP2SUqunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198298; c=relaxed/simple;
	bh=Uw2FiaqGMl761SWfGXIHbx7lQuyHidBlVpgGWwm+k4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+sxWcD7tbLBwZ5XKr88DYCmEzq/MSET1m4aZDP54/u1YBZkA0aqc81lr/PjNOECym1p2cBbuk9BYF5JEcgRzoSpsxV5rHDmrBtvsWjrSiCmJl6VkrPYQZMIW+5L+dQ+ZYcebtGeR4TC18rkF/YjDk15kYTiyvaXSArtgyUstzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eg2ElmpA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38242abf421so664481f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732198295; x=1732803095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HJcVtwAACwC4uPS1IF8o+pGP7DKNM9J+dC2VSwrYbs=;
        b=eg2ElmpAWfQ9JRY2GxBRZ/5CZIjjd+7QJUwJWIf+4QaR/kE+RGjxPQSNYb++3I2AG4
         0c4ibWusOhXMIF9mEx5oMksJvrEDU9uQBDY8QuIyanLpBfDOgVM5sofXlhrpAN2u2X/p
         SVOYzhSA59CHCUGOhX2EQLIdzEq4ATM5ozCyUoGFtTS169CAAMdDlaExHABF4DnoFojf
         r7FhBm/d9xASpG1OCwxftnN5nNhPEb9R4geyKL4Qsh4Yft6Ie8XoKkAbRpwN8M8UU1xr
         CdVunGt3T2G/rsgt+I0mRdHvH2FRG5G5BSZwF2T8cPijNy7KNoqjqWAnKIx/bkxBdhXK
         +bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198295; x=1732803095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HJcVtwAACwC4uPS1IF8o+pGP7DKNM9J+dC2VSwrYbs=;
        b=Hw3e1+BwMprxRZk3vcp6LX5EpkzzfmIRrM4GAFTnYwodJrXpL8WY8OUIDulzl0NCnP
         P028JZpWvRvR2cuJyrDN2cYeAwtqlMHZtAhkmBHV3dJXxYEc+8VF0kxJ6vwgHyaHtkzh
         lP9bhLp474BjpULdcux7cYgdP9zVhc29b+TyHyd3HRrgNS9h8odiK8toMTX5QqAaM5xp
         7DyTOrQr88ErF+j6gZzUTXoKzDQBEtvT8pNye9FqPRFigwCWQBknqYYLC8ptGZtCtalr
         V042k4blo9ewY0nnJ+HRDDCENd0ayo8YrK/NCV/kUTnAkX/NsuC1wNUMlF8AvX9xMjMC
         6Cnw==
X-Forwarded-Encrypted: i=1; AJvYcCU+cto3uWwmFpI3JKMcN67JakV3OxnP6iI5wGFODnX/YW1zyKqhQpvnzHUD88udIClbhn9tVp0VgItBn4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvMjFx85KQvuNVPvXXYy4BlnxC/NfOLF+Sq7I3IwXyGB6h8ov
	nCdf3z2XrD1cOjkz7i5Fe+RNbj4cUZetNCV+iZx0J4cqPow+Va92DOEXORn7YU4=
X-Gm-Gg: ASbGncu2ibDukdrn6LR0xh4Y5gA3zNawy9ehvWMBuX3Q/jFW7Hm2JzAMR1nr9y8ZsbH
	RZM/dGN5GUYLPVI7A1vlNOUijxE/VmOi+VpgxRqedgoFBPQk59UIATToZeBhAgezVkBPpB7sFpK
	p9OZmQjFvUg4YnF8xOMsgQBN3zdNRTV+gHGnYHZBab9DnQtK4kLhT0ernzgbCci3uj09TWE+L2f
	qhLZi+Jn88iSW6SDHMHWtaIWubeQ9xac24jatNlqpEr8CDF1ScoQw5QDD9V
X-Google-Smtp-Source: AGHT+IHJhwxxcRKJjxAsvH1hKFueQoCCj9Rk1klftfp0bdOZUzXmrqOdJxbga8Qwf4rziSS/MLDeQA==
X-Received: by 2002:a05:6000:210f:b0:382:3527:a14f with SMTP id ffacd0b85a97d-38254adedeemr3844751f8f.8.1732198293549;
        Thu, 21 Nov 2024 06:11:33 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:585:4e9c:5bc8:98f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c89asm5158683f8f.34.2024.11.21.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:11:33 -0800 (PST)
Date: Thu, 21 Nov 2024 15:11:29 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: qcom: apq8016_sbc: Fix second argument of
 apq8016_dai_init()
Message-ID: <Zz8_kZkKyetqnRr2@linaro.org>
References: <20241117232100.23760-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117232100.23760-1-spasswolf@web.de>

Hi,

On Mon, Nov 18, 2024 at 12:20:58AM +0100, Bert Karwatzki wrote:
> Since commit a78a42fb48b8 the second argument of apq8016_dai_init() has
> to be an lpass id returned by qdsp6_dai_get_lpass_id().
> 
> Fixes: a78a42fb48b8 ("ASoC: qcom: apq8016_sbc: Allow routing audio through QDSP6")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index 3023cf180a75..ddfcd4616895 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -150,7 +150,7 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> 
> -	return apq8016_dai_init(rtd, cpu_dai->id);
> +	return apq8016_dai_init(rtd, qdsp6_dai_get_lpass_id(cpu_dai));
>  }
> 

Hm no, the code is correct the way it is. There are two cases handled by
this driver:

 - ADSP bypass (lpass-* drivers, qcom,apq8016-sbc-sndcard): This one
   uses the LPASS IDs as DAI IDs, so cpu_dai->id already contains the
   correct value.

 - ADSP (qdsp6 drivers, qcom,msm8916-qdsp6-sndcard): This one uses the
   QDSP6 IDs (e.g. PRIMARY_MI2S_RX/TX instead of MI2S_PRIMARY), so
   qdsp6_dai_get_lpass_id() is used to translate that to the LPASS IDs.

The code you are changing here handles the first case (ADSP bypass),
the DAI IDs do not need any translation there.

Thanks,
Stephan

