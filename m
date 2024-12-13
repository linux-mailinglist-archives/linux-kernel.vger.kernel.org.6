Return-Path: <linux-kernel+bounces-445509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85089F1719
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8FC188820C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D294196434;
	Fri, 13 Dec 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="uwXO1U5j"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B118FC92
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120035; cv=none; b=BcJgATmphTbItd4WDEwfLSDWxgJPYjG8LMBEnuoSSjkUn38MZF2VpJzUpphRXvWMw432M4Zjw8z2L0735a1vmpZ4xD728W2tYsKvQQor6MzOOeuCDl0WeUUpkhcDC4jlp3p/mJ5vUpFmDjzaDgXAkaKLlIC46wOsTuFDZE8YSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120035; c=relaxed/simple;
	bh=x7L1gh88EutVaL8gMqGVvcTa671h3hZqDFZ59Eo9Gi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pT44vMFbJCt7uWmsSwK4SIZ8SdzPXePe0g5h9urznAfDLSJRslxj/Cqr3BWEtqL4lrBYUz6IbuxMM9GfyshoNTz2hDUWuRqv1Fk+Nc6j6OulBSWOx2a3q1JM8x80HauPCq28VsTSc06NSQC1rve7ablBmZIHmp1T0xWZgA8cu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=uwXO1U5j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6c70220f7so149646385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1734120032; x=1734724832; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74NlfA8P9+tD9kRaiQet/Cxkg9YE/hgCZpYkhiWFU3U=;
        b=uwXO1U5jthsoOGbzRU+qfhSP2KePKpuE+e9fFFvnSCmBHxefZM+hsMH25o7GSiWkpM
         tD9fbRK6SSiIvNZQCvQiqmirZaUU7upfcXDMsRx+J5GvJIPJjqPU2DrwHuB/AHXUC5au
         Gfdncs0Zo7bt+ML+/qvLacqYWfNb8uN7YjLG38YlLoygEPfklCdX4B8uw2CDEImbhFPi
         yuansqVCSPay9eoORtfDEO3eZUZUaHfOEIRYLX8yoNDS3M/UzbSmZx2dfQDlWs4vWNLg
         sGlm9Ymh/2InDk9Wli+W4QpjEKa8Kkk5Bpi7pLiTXdfMY+0Do5OUcSnPKWMHNu2fuI74
         VucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120032; x=1734724832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74NlfA8P9+tD9kRaiQet/Cxkg9YE/hgCZpYkhiWFU3U=;
        b=X+miDH2SVAt2qH9ZxXbeJjr4hUB2bCkpelxkRjcZk6dzYy9smy6wuiyCBSY7IlHetH
         9ouHeQwJKFbZuOW7jDgFpD1B/HBwLJ9Ys8F23StwCnqHDgpI5iOmZNxsXnGc52bTAPhp
         MJthM11ZkpwQhhKIThyQJ9lR2eHakK0Q3ZIjAV84zb4TmJbuTEL2VWoWv91gfQq99ltW
         5qWrMcKStgPPci27vOWy9BG3E/xfiPgZNApWO6VdjfCiyJ4MwSXXDjteJlbuxw8BAbwa
         HtEHLn7vazWCfKgRAeiW8acINOzz4Tz1mADygzgbTwNfKTLI0v8iTfsiDs7kYC6rDjvK
         XumQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjpJtQH4XT4hK7EWmKdjwSt+nOBcTS2LuIyExBH5ovhiWsGzt+5gKXyR1ck0C58H1FsJ6gkmpBXjk7VR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5lB6Mw3UAsjzUR6jFhV/+dOe2vJJXc/K6HlN9GsAWe31ZSqr
	/ZpgHxo88p0Qg+9yPICnSWTGBISnfypvjtvkJQPo4HYiVfJnIJb3AxwvbrHR7FU=
X-Gm-Gg: ASbGncsk1gKZH0+4goOqsBbA4C2FxAQOR1Cxp9oSyEtTkjsem/63VOo9reeFeMKujpb
	il6a+ZmPa+NIqSzE3cAeXgAM4wT1lbON5uurVjeH0ROJnyhRL0+ye/KC1qmq2Cac4VpzVCoWtWn
	hekTZ3RTK8j56b/MId2RuWAvlOUv6PBP47eNECmHAjWtB7ZK+c1V9Ad/YapEzBaJ+oESQppVd4F
	pqCFZ14madGiwWGkFj8G2Xx3h/xul03iKaez1+8kZmdU6Ia9YMA+0B/Hw==
X-Google-Smtp-Source: AGHT+IEgBOo9qrsoTJgwjsvTiFMjg9zNW9UJGmlOnPGOfek3hkRrxuu31Sg9ut+DFizInI+chF7DcA==
X-Received: by 2002:a05:620a:24c8:b0:7b6:91a4:845b with SMTP id af79cd13be357-7b6fbee6902mr750465585a.15.1734120031719;
        Fri, 13 Dec 2024 12:00:31 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:862e::7a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047aa677sm9924785a.20.2024.12.13.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:00:31 -0800 (PST)
Message-ID: <e159b61f620eea520b06e20a294bf84be781fe19.camel@ndufresne.ca>
Subject: Re: [PATCH v5 2/3] media: venus: Populate video encoder/decoder
 nodename entries
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Stanimir Varbanov	
 <stanimir.k.varbanov@gmail.com>, Vikash Garodia
 <quic_vgarodia@quicinc.com>,  Mauro Carvalho Chehab	 <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
	quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, 	linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org, Stanimir
 Varbanov <stanimir.varbanov@linaro.org>
Date: Fri, 13 Dec 2024 15:00:30 -0500
In-Reply-To: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-2-ef7e5f85f302@linaro.org>
References: 
	<20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-0-ef7e5f85f302@linaro.org>
	 <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-2-ef7e5f85f302@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Bryan,

Le lundi 09 d=C3=A9cembre 2024 =C3=A0 11:52 +0000, Bryan O'Donoghue a =C3=
=A9crit=C2=A0:
> Populate encoder and decoder node-name entries for the upstream parts. On=
ce
> done the compat=3D"video-encoder" and compat=3D"video-decoder" in the dts=
i can
> be dropped though the venus driver will continue to favour DT declared
> video-encoder/video-decoder declarations over static declarations for
> compatibility.

Hope this hardcoding of node name is historical ? And not done for newer ch=
ips ?
We discourage userspace on relying on node names cause it always leads to
complication and non-portable code.

Nicolas

>=20
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/pla=
tform/qcom/venus/core.c
> index 88dfa9f240dc6d18a7f58dc06b1bf10274b7121e..deef391d78770b8ae0f486dd3=
a3ab44c4ea6a581 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -674,6 +674,8 @@ static const struct venus_resources msm8916_res =3D {
>  	.vmem_addr =3D 0,
>  	.dma_mask =3D 0xddc00000 - 1,
>  	.fwname =3D "qcom/venus-1.8/venus.mbn",
> +	.dec_nodename =3D "video-decoder",
> +	.enc_nodename =3D "video-encoder",
>  };
> =20
>  static const struct freq_tbl msm8996_freq_table[] =3D {
> @@ -883,6 +885,8 @@ static const struct venus_resources sdm845_res_v2 =3D=
 {
>  	.cp_nonpixel_start =3D 0x1000000,
>  	.cp_nonpixel_size =3D 0x24800000,
>  	.fwname =3D "qcom/venus-5.2/venus.mbn",
> +	.dec_nodename =3D "video-core0",
> +	.enc_nodename =3D "video-core1",
>  };
> =20
>  static const struct freq_tbl sc7180_freq_table[] =3D {
> @@ -931,6 +935,8 @@ static const struct venus_resources sc7180_res =3D {
>  	.cp_nonpixel_start =3D 0x1000000,
>  	.cp_nonpixel_size =3D 0x24800000,
>  	.fwname =3D "qcom/venus-5.4/venus.mbn",
> +	.dec_nodename =3D "video-decoder",
> +	.enc_nodename =3D "video-encoder",
>  };
> =20
>  static const struct freq_tbl sm8250_freq_table[] =3D {
> @@ -986,6 +992,8 @@ static const struct venus_resources sm8250_res =3D {
>  	.vmem_addr =3D 0,
>  	.dma_mask =3D 0xe0000000 - 1,
>  	.fwname =3D "qcom/vpu-1.0/venus.mbn",
> +	.dec_nodename =3D "video-decoder",
> +	.enc_nodename =3D "video-encoder",
>  };
> =20
>  static const struct freq_tbl sc7280_freq_table[] =3D {
> @@ -1048,6 +1056,8 @@ static const struct venus_resources sc7280_res =3D =
{
>  	.cp_nonpixel_start =3D 0x1000000,
>  	.cp_nonpixel_size =3D 0x24800000,
>  	.fwname =3D "qcom/vpu-2.0/venus.mbn",
> +	.dec_nodename =3D "video-decoder",
> +	.enc_nodename =3D "video-encoder",
>  };
> =20
>  static const struct of_device_id venus_dt_match[] =3D {
>=20


