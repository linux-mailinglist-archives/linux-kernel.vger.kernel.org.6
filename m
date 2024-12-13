Return-Path: <linux-kernel+bounces-444793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB89F0C96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72813162378
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BC1DF256;
	Fri, 13 Dec 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmmiJN6+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D371B87E8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093678; cv=none; b=iR/C95tkcodPyfTm6czFvpknq6M9kyU5OouMxawhumExQH27XmypJoXDkdC7nLZlDU77yNJmYmXn9C6/i71l/fjW6BNlG2JYjVcFxrw0zdhWceHPwEm+nPWJMRqvABLY9obfo0kDPdWzQtcXAT0crLcpKTb9EIy8SjTESN9+UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093678; c=relaxed/simple;
	bh=NWqQTnku2IFewnQ0l271ypTAiqVof9cxtyCXjtDznm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdO7PENiuXpE55ndntEJpFXXiZXvHKBJF/PKL4BDlI4Se530QYvbPcRwEurPGOmwxV4mFq0G9UQOgxK6MHs8eyzJVlk67gjhwYEGY1O7xHADCCaabfSpvFmjJb+JUX2L17JOg0e2srFdv3XwHY0Mk/uTn4qQWpqPO1nC5Oim0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmmiJN6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDABdPK006448
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yenE09Qp1TRoV+p0D59Cwj/cworX8HYkWewV+iHsfWI=; b=jmmiJN6+lnb1z3FU
	cT1RN+NKkmiVknqaBZAFwv3BxjPZqELQSygeVaENs9RdhpjIexuNIAywVUfJVU0f
	o4BdQvQZqhSe2QtYVrNopdz9DnAvfparxh4g8dUWtybBWkv8PYYMn0ZjvD86oSYl
	L0MzhakU+TuovDpN3HPoD/hpME8G3KEKY0TKzkHHwx5Pxh5Ve6Fm1aK+XR42tirg
	5kVvDB6JMsd7o00yzY1NKRkNZWKaO4JU/A+hzJDbGyrXDShaOb0zvbEbpyV/mX/+
	PFwR/70J+O0b7nt4qYbMzQrGB/M0YmIBwKGUT5FmCVS4x0vbYEuHRlqxdJ+bL9H/
	xGEn/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tffkr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:41:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4678aa83043so4309001cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093674; x=1734698474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yenE09Qp1TRoV+p0D59Cwj/cworX8HYkWewV+iHsfWI=;
        b=uVSQWpd4BAqJZiqpJsp8MAmzUaXrZDfBOxGDPfwBtzKpBCh6RFa+iZkrOs6QzTj/rv
         5VeMZ1WXXivMaY+sxL0DioHJgVYIsNlnyaQ3Ao7AeD3bSCMg7O3J+0/t9p+7SkzObLdW
         wjz+GAmkPr8qE5q8gotZo6oEIhfVOrNYeOsHTRrWO/BoQj3xsUE0/54dvcseSr05tRvI
         W+CU/ETAMLO0Ne46ieuuYNiHFDN6S2PDJUhGoFKlPatFwPlGvWtHtxdyk73V33/AhLPz
         JakwvgslzKAoyl+W+XgOoLNlzqMW0RHxWJf4amqulHiaS/LAjPU9YriITQxxeU/IKaaJ
         gPAw==
X-Forwarded-Encrypted: i=1; AJvYcCVyk13ho9DC9+DFSdpWvcYOLYElGJzAfwIdeEZSo+TcsrumReULuwT3XlscOhPcBC1lmCS+6R+SDsTDE3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaW1ptaxC6Nv8orhejEgekd7lzknZ1Uf0aXpS6qsjveYlW5kE7
	QssQGK9ygORbqNxlvVjNDRj/2vO+rS1olc9DXTzqYMNnk4JYTe1h8S+vYo7fcaCuscrkKbKxPei
	IWzLFu+7Mywng/lDqXH1l+e9pIBGUr6NGRw7/QSHbxH/zMY2NY4ybfq+ufb4calJwzpxH7Ys=
X-Gm-Gg: ASbGncv19xMQ5tMQEFTL6y6RZa5RX8VnRH7Ig8pxZI+fuv8+RZ5yBON0jp5eEyHMGKY
	SC4JPOlnKlBocXGxddUw7TOV8dAu+TQ03nBJ6Xqghfh7P1ne5DtX2O4UUxudx5E7wICqGXvQ0XP
	UKhgTCkf80NOYR50xL8Sf+hKthfk2kIjW5fp+burQftPTOavWxDQMGZniUQ5imTxs61/fzn6/hN
	Wqn/8m3BX5AK1oU1Hxqb3Jf4Y93PQ+pSM21F048oYyHzo+u7I2wEV+Ek+xKXicWUjhmyydEpYkF
	50hcQq+UUs/DFwKF1OgP/sWhRgnoIsRrhv5e
X-Received: by 2002:ac8:5d0e:0:b0:466:92d8:737f with SMTP id d75a77b69052e-467a578b90dmr14355731cf.8.1734093674058;
        Fri, 13 Dec 2024 04:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1IHSeIv2Brdx5RvV0G26ngkWwAvpQUxQLtvdE3yXcXS+13NNnafO8QCrJMN1uf6O8p0bICA==
X-Received: by 2002:ac8:5d0e:0:b0:466:92d8:737f with SMTP id d75a77b69052e-467a578b90dmr14355631cf.8.1734093673746;
        Fri, 13 Dec 2024 04:41:13 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474d96sm820844966b.96.2024.12.13.04.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:41:13 -0800 (PST)
Message-ID: <e2fba6e9-6548-44fe-a15c-cd29f5650b74@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:41:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] arm64: dts: qcom: qrb4210-rb2: add WSA audio
 playback support
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org,
        konradybcio@kernel.org, konrad.dybcio@oss.qualcomm.com,
        andersson@kernel.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
 <20241212004727.2903846-13-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212004727.2903846-13-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2tZM0-q1JVRo7J9BfKRQ0Wpp8kuAYHHK
X-Proofpoint-ORIG-GUID: 2tZM0-q1JVRo7J9BfKRQ0Wpp8kuAYHHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130089

On 12.12.2024 1:47 AM, Alexey Klimov wrote:
> Add support for audio playback via WCD937X/WSA881X. From DSP
> and rxmacro the sound stream goes into AUX port of wcd codec.
> wcd codec decodes digital audio into analog and outputs it to
> single wsa amplifier hence only the mono configuration.
> 
> The audio playback is verified using the following commands:
> 
> amixer -c0 cset iface=MIXER,name='AUX_RDAC Switch' 1
> amixer -c0 cset iface=MIXER,name='RX_RX2 Digital Volume' 80
> amixer -c0 cset iface=MIXER,name='RX INT2_1 MIX1 INP0' 'RX2'
> amixer -c0 cset iface=MIXER,name='RX_CODEC_DMA_RX_1 Audio Mixer MultiMedia1' 1
> amixer -c0 cset iface=MIXER,name='RX_MACRO RX2 MUX' 'AIF2_PB'
> amixer -c0 cset iface=MIXER,name='SpkrMono WSA_RDAC' 1
> amixer -c0 cset iface=MIXER,name='LO Switch' 1
> amixer -c0 cset iface=MIXER,name='RX HPH Mode' 4
> 
> aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 827ce5f7adfb..34ba563d0d07 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -111,7 +111,9 @@ sound {
>  		pinctrl-0 = <&lpi_i2s2_active>;
>  		pinctrl-names = "default";
>  		model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
> -		audio-routing = "MM_DL1", "MultiMedia1 Playback",
> +		audio-routing = "IN3_AUX", "AUX_OUT",
> +				"SpkrMono WSA_IN", "AUX",
> +				"MM_DL1", "MultiMedia1 Playback",
>  				"MM_DL2", "MultiMedia2 Playback";
>  
>  		mm1-dai-link {
> @@ -145,6 +147,22 @@ codec {
>  				sound-dai = <&lt9611_codec 0>;
>  			};
>  		};
> +
> +		wsa-dai-link {
> +			link-name = "WSA Playback";
> +
> +			cpu {
> +				sound-dai = <&q6afedai RX_CODEC_DMA_RX_1>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6routing>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wsa881x>, <&wcd937x 0>, <&swr1 3>, <&rxmacro 1>;
> +			};

Please sort these subnodes alphabetically - and yes I realize
we managed to overlook that for 10 years

lgtm otherwise

Konrad

