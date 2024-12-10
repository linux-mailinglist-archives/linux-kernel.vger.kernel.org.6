Return-Path: <linux-kernel+bounces-439854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B49EB4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C2280E66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE891BBBE5;
	Tue, 10 Dec 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foNHM3XR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC578F23
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844503; cv=none; b=Y8oeZYgKl+Sp1kcQ9eZY1gDGAGrJ/Pq9JKEgypaQT/7geGPdLQlGIWspPDielipKLryvwNd4ZPTYnyhXJwZJUHLVJBv/665iTcsLYeHe4WncEyi/6Y2e1Iq8AMs3aRRnMb9hxgJUpFS1aWL8dY7CNK/MAcB7pjzDJzwHxJSsi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844503; c=relaxed/simple;
	bh=RGx/4zBsSMwPqrQWbZ4pbyO14Aa3YKWohJLO/gCree0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfhMAcsPZJ19kmu9tA7zqkocUVb3l6aob8FWzVqaXGHsWO8ctM//awBuuhV4JFAluLDsvNw/Bra3UaUiIBidladUJ9dT18GJI82TKlLF/8pXoqtG5Ap4z887EEBI85OA1FUtLOKpP1iVXnp2Hzs7AWZPzCeS2hXE70ZfYjgmu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foNHM3XR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30219437e63so25051091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733844499; x=1734449299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KTmXu/GwcDjLblR23LnM4eXZJnu7tzwhaXJ+YJcxbQ=;
        b=foNHM3XRdoco9RjELiiD8nywhN8Udq4F+xprUKMmF1Gyx+vIh0hIe4bU/AtEi54s1l
         hsWpLdTBiHh3mIrXhp2WRHs7ncOaK3+p7PgJAKp03uJUU1Y5sv2ifHgvshqAzXjEyQuW
         X3WXWE4+vge95ubWqdbTLIaPQov23RqZ9c+xLeZ73boojEO9R5ouz/QPFDXZwEWum3Li
         PFNvehxgFOyP8EoLjFr41HBZ+SO1EwhdOgkmnoAz7kQBiRdY+apEKcmfae5XNbw/f6pe
         Gr6hInUF/fdTmmE6xTlisvjXBrsWKSy3IMKQ03jtT7Sua8+rwt1wlvXDCizdJmaqBiFZ
         CY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844499; x=1734449299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KTmXu/GwcDjLblR23LnM4eXZJnu7tzwhaXJ+YJcxbQ=;
        b=FGICZlWiLdLmenAfOYzQadl1jr3NddaR8v5HLzfdIPaepmZWQIvYMkhLbNtmPUnVd8
         CuLuo6SLTHUrR43D3Ulafbl1jcCIxN7IQR3mfr1rRU/fOOjcBHh1sYtbLpJj72Rx1yKH
         IRpHuXV0beleF2FPQf8qh7/WNJpQ8uOk/aATJkVl0K7uovX6614Jev2aJ5mkOH7mM9eS
         LE+NGMjJFJI4wZQNXal8zXJR0kdyGmMl4yXUB+Zw4xJmRcXvV6LTLdzsMsYp1FJn8Jzc
         7em7vKVKaKyzapxxUyhPld8uDn2OMX7YNFJtYghPcnsOypfff1wViDJYzOj1Fcz9//Je
         CzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN7N7tcLBbiRUUjcOvwrGjyLNLdRb9c5lRF/cTXIm6uFVQKU5oZIDJ0/D82iguIInXgaWEOy1dB0q+s68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdU2NqnZgT+kgk8IJ6PbARh6BOHwrSC1LjDIPgCfuDel0wajR
	C4v6Cq6zV9hPtyPU+C6J22gza9Oueo6ofnd7K2VA45PU4Du5V4q55WbPZooTass=
X-Gm-Gg: ASbGnct/HgACpHiKddSSb6eW81W6tEFDdSZyw0FWXu39UVZwiK90DShZgOCO4jI5lTA
	kyeu+6JXB/ubXArnV9zpMQBmmdkPs1BTXwkDA61B3RqecdMuFNlInZFjI87q78lkISpna/sY6qY
	YAgqBV3e8x9t0xrN1/+/7MsDuAsPBAf9cjnDGYmw/n0mlHjc8Zsv2Ysg/5iGNSJ3x98CoJrJiH0
	ccU1IbeR6/6VzM6Cgc7FTY7UBN+bjs+FXzmldg9SQeWFycBMsGvjiL7gX9KK0xrooxGbVgbiVft
	jV1L8pet9W+lULmNWKYhfdos6WZEOcid6w==
X-Google-Smtp-Source: AGHT+IE0XKiVkUgg9tF/sqxHHXF50bH/FmLp2/h2auq4iq6OuW3GAlEcYLIz8mLjof0Tf/Bo6/ygjQ==
X-Received: by 2002:a2e:a548:0:b0:300:3307:389f with SMTP id 38308e7fff4ca-302327404afmr11387881fa.0.1733844499239;
        Tue, 10 Dec 2024 07:28:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3023c5115d2sm1304271fa.12.2024.12.10.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:28:17 -0800 (PST)
Date: Tue, 10 Dec 2024 17:28:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, 
	quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: Re: [PATCH v4 2/4] Bluetooth: qca: Add support in firmware-name to
 load board specific nvm
Message-ID: <wxb6oo3f7cri27eq3fnqttbl74lkn3rjo5o5rfttbwz7k5v2ug@w4hlrtig2nza>
References: <20241210151636.2474809-1-quic_chejiang@quicinc.com>
 <20241210151636.2474809-3-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210151636.2474809-3-quic_chejiang@quicinc.com>

On Tue, Dec 10, 2024 at 11:16:34PM +0800, Cheng Jiang wrote:
> Different connectivity boards may be attached to the same platform. For
> example, QCA6698-based boards can support either a two-antenna or
> three-antenna solution, both of which work on the sa8775p-ride platform.
> Due to differences in connectivity boards and variations in RF
> performance from different foundries, different NVM configurations are
> used based on the board ID.
> 
> Therefore, in the firmware-name property, if the NVM file has an
> extension, the NVM file will be used. Otherwise, the system will first
> try the .bNN (board ID) file, and if that fails, it will fall back to
> the .bin file.
> 
> Possible configurations:
> firmware-name = "QCA6698/hpnv21";
> firmware-name = "QCA6698/hpnv21.bin";
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c | 67 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac922..deb2b1753 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -272,6 +272,27 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
>  
> +static bool qca_get_alt_nvm_path(char *path, size_t max_size)
> +{
> +	char fwname[64];
> +	const char *suffix;
> +
> +	suffix = strrchr(path, '.');
> +
> +	/* nvm file name has a suffix, replace with .bin */
> +	if (suffix && suffix != path && *(suffix + 1) != '\0' && strchr(suffix, '/') == NULL) {
> +		strscpy(fwname, path, suffix - path + 1);
> +		snprintf(fwname + (suffix - path), sizeof(fwname) - (suffix - path), ".bin");
> +		/* If nvm file is already the default one, return false to skip the retry. */
> +		if (strcmp(fwname, path) == 0)
> +			return false;
> +
> +		snprintf(path, max_size, "%s", fwname);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static int qca_tlv_check_data(struct hci_dev *hdev,
>  			       struct qca_fw_config *config,
>  			       u8 *fw_data, size_t fw_size,
> @@ -564,6 +585,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  					   config->fwname, ret);
>  				return ret;
>  			}
> +		}
> +		/* For nvm, if desired nvm file is not present and it's not the
> +		 * default nvm file(ends with .bin), try to load the default nvm.
> +		 */
> +		else if (config->type == TLV_TYPE_NVM &&
> +			 qca_get_alt_nvm_path(config->fwname, sizeof(config->fwname))) {
> +			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> +			ret = request_firmware(&fw, config->fwname, &hdev->dev);
> +			if (ret) {
> +				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +					   config->fwname, ret);
> +				return ret;
> +			}
>  		} else {
>  			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>  				   config->fwname, ret);
> @@ -730,6 +764,26 @@ static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
>  			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
>  }
>  
> +static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
> +		const char *firmware_name, struct qca_btsoc_version ver,
> +		enum qca_btsoc_type soc_type, u16 bid)
> +{
> +	const char *variant;
> +
> +	/* Set the variant to empty by default */
> +	variant = "";
> +	/* hsp gf chip */
> +	if (soc_type == QCA_WCN6855) {
> +		if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> +			variant = "g";
> +	}
> +
> +	if (bid == 0x0 || bid == 0xffff)
> +		snprintf(fwname, max_size, "qca/%s%s.bin", firmware_name, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/%s%s.b%02x", firmware_name, variant, bid);

So, we have qca_generate_hsp_nvm_name(), qca_get_nvm_name_generic(), now
you are adding a third one. Can we please have a single function that
handles that?

> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)
> @@ -739,6 +793,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	u8 rom_ver = 0;
>  	u32 soc_ver;
>  	u16 boardid = 0;
> +	const char *suffix;
>  
>  	bt_dev_dbg(hdev, "QCA setup on UART");
>  
> @@ -816,8 +871,16 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	if (firmware_name) {
> -		snprintf(config.fwname, sizeof(config.fwname),
> -			 "qca/%s", firmware_name);
> +		/* The firmware name has suffix, use it directly */
> +		suffix = strrchr(firmware_name, '.');
> +		if (suffix && suffix != firmware_name &&
> +			*(suffix + 1) != '\0' && strchr(suffix, '/') == NULL) {

The have-suffix code should be extracted to a helper function. You have
two copies of it.

> +			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
> +		} else {
> +			qca_read_fw_board_id(hdev, &boardid);
> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +				 firmware_name, ver, soc_type, boardid);
> +		}
>  	} else {
>  		switch (soc_type) {
>  		case QCA_WCN3990:
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

