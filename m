Return-Path: <linux-kernel+bounces-209142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F9902DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F021F23412
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D36FC5;
	Tue, 11 Jun 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="XhB5QTbi"
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313163B8;
	Tue, 11 Jun 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067836; cv=none; b=JLhHQkmExdLZlK1zCAQHNaPrXELF6xuavrl0nmx/DdGm2MJ62H9Ij16I/cAfv0NKRxMJnt2Q165kUScX0nPRH9llKfSqTfxe3TG3uudB8QKL4iH+4X5pnSyMX1IpZW9gdi18518sNIuLw/xNnp3lSTUJWR45U+OiTprSMc1ySiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067836; c=relaxed/simple;
	bh=dhKRHtF4SgAN+8QKhbvAqBOVF8bJZ+pKcc9susdjNyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iioirkBRVa4U3JeUVqfeDXwR5cWiwO5fH+zHq59QJIapETrzHNCRe+ZUPBA4gorNnHxGBxL5YYgyj8BTYyAcF+FMwS5HVrGFMf7kFD5LF6gYLZbZaYClx0cJg5YTFBduIQRKfQLpN8krvDnrAMe3j8+pxXHzlQNTVOmP38zDoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=XhB5QTbi; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jWkaSxfNx+pzsfSK1fY94WQ4Jtn8QLkhhm2QngdCkpA=; b=XhB5QTbiDTZ0gTP04i5yOGIXAj
	14BvTDKEOtr0ApCPNT/sfFqCixnn8O9csTMMUXe2pQy1YADBClpCkgjyF/RnF46cVMgNg6++tfIqH
	JlorxJ5baLZ05f3TI+akEBTuq46ojoty1UE+HJC2IMglqjvNFP/tgT96+rj7yfM6u0EQj7B7Qjye0
	dRvx7PwFExfMuR4ccyJn56ugKioQwRhfbFZZ9I6K2DLpN0S+C6y2RynWEURzdyL3FYpALb/Ee1gVM
	XjCJcJOIa0S7qXed0Gzm3e1HHZuNuETOMMCSN6aJaFPfHWyMq9DOfAlncGXNfz8Wn50drVwX9mbfK
	rzY/EU8A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1sGpe8-000MIq-UQ; Tue, 11 Jun 2024 02:45:56 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1sGpe8-000ME2-2Z;
	Tue, 11 Jun 2024 02:45:56 +0200
Message-ID: <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
Date: Mon, 10 Jun 2024 17:45:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ALSA: dmaengine: Synchronize dma channel in
 prepare()
To: Jai Luthra <j-luthra@ti.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
 <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27302/Mon Jun 10 10:25:43 2024)

On 6/10/24 03:56, Jai Luthra wrote:
> Sometimes the stream may be stopped due to XRUN events, in which case
> the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
> start the stream again.
>
> In these cases, we must wait for the DMA channel to synchronize before
> marking the stream as prepared for playback, as the DMA channel gets
> stopped by snd_pcm_drop() without any synchronization.


We should really implement the sync_stop() PCM callback and let the ALSA 
core let care of the sync.


> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   include/sound/dmaengine_pcm.h         |  1 +
>   sound/core/pcm_dmaengine.c            | 10 ++++++++++
>   sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
>   3 files changed, 19 insertions(+)
>
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index c11aaf8079fb..9c5800e5659f 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -36,6 +36,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
>   int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
>   	struct dma_chan *chan);
>   int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
> +int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream);
>   
>   int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
>   	dma_filter_fn filter_fn, void *filter_data);
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 12aa1cef11a1..dbf5c6136d68 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -349,6 +349,16 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
>   }
>   EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
>   
> +int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> +
> +	dmaengine_synchronize(prtd->dma_chan);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_prepare);
> +
>   /**
>    * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
>    * @substream: PCM substream
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index ea3bc9318412..078fcb0ba8a2 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -318,6 +318,12 @@ static int dmaengine_copy(struct snd_soc_component *component,
>   	return 0;
>   }
>   
> +static int dmaengine_pcm_prepare(struct snd_soc_component *component,
> +				 struct snd_pcm_substream *substream)
> +{
> +	return snd_dmaengine_pcm_prepare(substream);
> +}
> +
>   static const struct snd_soc_component_driver dmaengine_pcm_component = {
>   	.name		= SND_DMAENGINE_PCM_DRV_NAME,
>   	.probe_order	= SND_SOC_COMP_ORDER_LATE,
> @@ -327,6 +333,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
>   	.trigger	= dmaengine_pcm_trigger,
>   	.pointer	= dmaengine_pcm_pointer,
>   	.pcm_construct	= dmaengine_pcm_new,
> +	.prepare	= dmaengine_pcm_prepare,
>   };
>   
>   static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
> @@ -339,6 +346,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
>   	.pointer	= dmaengine_pcm_pointer,
>   	.copy		= dmaengine_copy,
>   	.pcm_construct	= dmaengine_pcm_new,
> +	.prepare	= dmaengine_pcm_prepare,
>   };
>   
>   static const char * const dmaengine_pcm_dma_channel_names[] = {
>


