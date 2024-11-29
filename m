Return-Path: <linux-kernel+bounces-424695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3B9DB834
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B36B2134E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38E1A0B05;
	Thu, 28 Nov 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsO3naFq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5D19CD17
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798938; cv=none; b=AJqn9o3BawdLAVuSW60zND6J0WpDEp4auRfa5hbGG7OkK7J2w0y9PzjHoxSSEIGgtQcEP1Tz3wmxFvmr1IkgcYjFh244H65qMH1d/6RK0FDN1bJmALObRsfprKeCFcMbR8DKgRiRx0LpPvcivFEjWgzTtiAlw2R1Q3nl/FJk7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798938; c=relaxed/simple;
	bh=qoMUoVkRdnNklCZVen39grW1C2CcfQG+FXuNGWucN54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVm/0OzMyqUHTSbciMGH9ZoLV9MrL6sMcB91BmMk02ha/Fm2O0lEjSkXLPJHv6C1kXWJsGuTeRJfGHY0beWpkeC9sP6YyfZ4hWbPAsX2iYepx57b7zddhfjo/4CobFkMCGu+yVXguqKPE7xXtmcnHUehB40IXl/vnZbC0k6zW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsO3naFq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd668c5easo867043e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798934; x=1733403734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltDNAlnzoVNe+Ei0fOeRuKYZM09QG0abkrt47Fv0wv4=;
        b=FsO3naFq+y4s0TOpApliCUxWEhOUPMZs+PHXcqXuyREYRDA5K/7bNjZ9jX3XJDYy8M
         q3+Rzcg9kMPGAYsD1SRvKK1wkMwdetpa2NWuBEugwc7TaZRGSpjuUvY2k39EO38VpN28
         CaplsDQAY54dfN976wDuzWWsggzrtJPiI/46HxpJ3L7GA7jsEh28/UhqyOAiDkPHFZkR
         Iy/cUrwl46xBoxIvOXb83aGl+ZRUp9o4ncqSNbHVBRouX15SxH9nBdk0WZlgZv3+uUHt
         7afgPAUQF/k02ad1Tl/Rg5hzpjUHnYIrKfhM1nMSZ/0UHLrj7Ro1r9zisgXdWKb42U+v
         3UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798934; x=1733403734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltDNAlnzoVNe+Ei0fOeRuKYZM09QG0abkrt47Fv0wv4=;
        b=PiqIQTxeDcdgHB0ESDaCAWhXOJmEVVNXagR4M48kMb3Zub6ktZuBtXNd8Vuo390Gfs
         oxoRf3+7tww/GtMmRuoe1TriMeW9J0AAhqvMxnr0VskUB6Sv+dPLKp/eYe/wCGAfkGAP
         /+KxSDHYkEak1d7QqBPQGsmqLk63wC55eZhuQ0FldTfJKm3THnkhU5A6mmY2taol+9DR
         bEl9nD9sPv0WaPfPqq4rJk6sIPhYc1BnCj63Q3AnhIltgTmSKTFu3gNoEl+B4/l967w/
         txPuZtZ0wIh6S8CL7wscnPeYNT2WaGJxyWnd55tinCpr5A8tMfdaEliFXvWHm7eSyddA
         odMw==
X-Forwarded-Encrypted: i=1; AJvYcCVfgxyvS0ceevfbU+0HB4MnOb6Ish7AbfHQBP8RcYkTQEz97BqPozxMOVCrfEN/5CcE1xI6Oj8QmV8mT14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOJA5m99/RSLHJyGoeUFMPpDoCsor+YoYd49VwXXyKfxR7rgu
	dH0ej5frl0h/n8eKe0G+acti8+VN/H/GuAZe9Lxnj2JM6myGtDscIfuFwyKFrSA=
X-Gm-Gg: ASbGncsSmie94gZPdchozT5OeGB5Vd34MKAbarYQ0Pmf2x5Z3AXLJsHRE9NBDlKAFSV
	dyjdLXZ1nNd6lsqCM8O4nGhxT4EdmIVidLS07+hZilxQ3FbLm4ydoP71AjPWZMc6SBE8vwaESet
	f7Z7g36EbxZVRBrwo92mrGfLpvk8rdjfbmDY7xdXUGgvU4RTLx6EF5GUGX+n/BxbLjjD7vZwGdB
	8L165V11/CBk9UHhtIpSyLzMU++e4G/bE6XyI4y4hNHlORShSc7t+HsRV223Z8TNukcCtYJj9Ba
	qk5u5iMa8psu75alh2cRhFa6AgXXaA==
X-Google-Smtp-Source: AGHT+IEbh5bAKEx0tRZtczoKntF5X/OerRAoAg27tLQabakzDKH8XH8YmSaAzb8icCxUTM2QDyGPwg==
X-Received: by 2002:ac2:5687:0:b0:53d:ed29:43ac with SMTP id 2adb3069b0e04-53df5080beamr1007091e87.28.1732798933542;
        Thu, 28 Nov 2024 05:02:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f328sm172175e87.149.2024.11.28.05.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:02:12 -0800 (PST)
Date: Thu, 28 Nov 2024 15:02:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_bt@quicinc.com
Subject: Re: [PATCH v1 3/3] Bluetooth: btqca: Add QCA6698 support
Message-ID: <xb4jdkkssgy3pmgd2iwawthsbocginbfeb2sbuneztshjiksdl@zswbbijyhxk4>
References: <20241128120922.3518582-1-quic_chejiang@quicinc.com>
 <20241128120922.3518582-4-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128120922.3518582-4-quic_chejiang@quicinc.com>

On Thu, Nov 28, 2024 at 08:09:22PM +0800, Cheng Jiang wrote:
> Add support for the QCA6698 Bluetooth chip, which shares the same IP core
> as the WCN6855. However, it has different RF components and RAM sizes,
> requiring new firmware files. This patch adds support for loading QCA6698
> rampatch and NVM from a different directory.
> 
> Due to variations in RF performance of QCA6698 chips from different
> foundries, different NVM configurations are used based on board ID.
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 47 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  1 +
>  drivers/bluetooth/hci_qca.c | 36 ++++++++++++++++++++++++++--
>  3 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac922..24bf00cac 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -700,6 +700,21 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
>  	return 0;
>  }
>  
> +int qca_check_firmware_exists(const char *name, struct hci_dev *hdev)
> +{
> +	const struct firmware *fw;
> +	int ret;
> +
> +	ret = firmware_request_nowarn(&fw, name, &hdev->dev);
> +	if (ret) {
> +		bt_dev_warn(hdev, "Firmware %s does not exist. Use default", name);

No useless warnings

> +		return 0;
> +	}
> +
> +	release_firmware(fw);
> +	return 1;
> +}
> +
>  static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
>  		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
>  {
> @@ -730,6 +745,26 @@ static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
>  			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
>  }
>  
> +static void qca_get_qca6698_nvm_name(struct hci_dev *hdev, char *fwname,
> +		size_t max_size, struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
> +{
> +	const char *variant;
> +
> +	/* hsp gf chip */
> +	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid != 0x0)
> +		snprintf(fwname, max_size, "qca/QCA6698/hpnv%02x%s.b%04x", rom_ver,
> +			 variant, bid);
> +
> +	/* if board id is 0 or the nvm file doesn't exisit, use the default */
> +	if (bid == 0x0 || !qca_check_firmware_exists(fwname, hdev))
> +		snprintf(fwname, max_size, "qca/QCA6698/hpnv%02x%s.bin", rom_ver, variant);

So, do you want to load the same firmware twice? You've asked for it
already, if it is present, use it.

Anyway, if you have followed previous discussions, you'd have known that
it has been recommended to use DT's firmware-name instead of pushing
everything to the driver.

> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)
> @@ -796,6 +831,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/hmtbtfw%02x.tlv", rom_ver);
>  		break;
> +	case QCA_QCA6698:
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/QCA6698/hpbtfw%02x.tlv", rom_ver);
> +		break;
>  	default:
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/rampatch_%08x.bin", soc_ver);
> @@ -810,7 +849,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Give the controller some time to get ready to receive the NVM */
>  	msleep(10);
>  
> -	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> +	if (soc_type == QCA_QCA2066 || soc_type == QCA_QCA6698)
>  		qca_read_fw_board_id(hdev, &boardid);
>  
>  	/* Download NVM configuration */
> @@ -854,6 +893,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		case QCA_WCN7850:
>  			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
>  			break;
> +		case QCA_QCA6698:
> +			qca_get_qca6698_nvm_name(hdev, config.fwname,
> +				sizeof(config.fwname), ver, rom_ver, boardid);
> +			break;
>  
>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
> @@ -874,6 +917,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		err = qca_disable_soc_logging(hdev);
>  		if (err < 0)
>  			return err;
> @@ -909,6 +953,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		/* get fw build info */
>  		err = qca_read_fw_build_info(hdev);
>  		if (err < 0)
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index bb5207d7a..67c16d8f2 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -151,6 +151,7 @@ enum qca_btsoc_type {
>  	QCA_WCN3991,
>  	QCA_QCA2066,
>  	QCA_QCA6390,
> +	QCA_QCA6698,
>  	QCA_WCN6750,
>  	QCA_WCN6855,
>  	QCA_WCN7850,
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 37129e6cb..70bdc046c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1361,6 +1361,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		usleep_range(1000, 10000);
>  		break;
>  
> @@ -1447,6 +1448,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>  		    !qca_get_speed(hu, QCA_OPER_SPEED))
>  			return -EINVAL;
> @@ -1489,6 +1491,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		case QCA_WCN6750:
>  		case QCA_WCN6855:
>  		case QCA_WCN7850:
> +		case QCA_QCA6698:
>  			hci_uart_set_flow_control(hu, true);
>  			break;
>  
> @@ -1523,6 +1526,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		case QCA_WCN6750:
>  		case QCA_WCN6855:
>  		case QCA_WCN7850:
> +		case QCA_QCA6698:
>  			hci_uart_set_flow_control(hu, false);
>  			break;
>  
> @@ -1803,6 +1807,7 @@ static int qca_power_on(struct hci_dev *hdev)
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
>  	case QCA_QCA6390:
> +	case QCA_QCA6698:
>  		ret = qca_regulator_init(hu);
>  		break;
>  
> @@ -1878,6 +1883,10 @@ static int qca_setup(struct hci_uart *hu)
>  		soc_name = "qca2066";
>  		break;
>  
> +	case QCA_QCA6698:
> +		soc_name = "qca6698";
> +		break;
> +
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
>  	case QCA_WCN3991:
> @@ -1919,6 +1928,7 @@ static int qca_setup(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>  		if (qcadev->bdaddr_property_broken)
>  			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
> @@ -1952,6 +1962,7 @@ static int qca_setup(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		break;
>  
>  	default:
> @@ -2089,6 +2100,20 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>  	.num_vregs = 0,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qca6698 __maybe_unused = {
> +	.soc_type = QCA_QCA6698,

No. It's the same as WCN6855. You don't need extra SoC type for it.

> +	.vregs = (struct qca_vreg []) {
> +		{ "vddio", 5000 },
> +		{ "vddbtcxmx", 126000 },
> +		{ "vddrfacmn", 12500 },
> +		{ "vddrfa0p8", 102000 },
> +		{ "vddrfa1p7", 302000 },
> +		{ "vddrfa1p2", 257000 },
> +	},
> +	.num_vregs = 6,
> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
> +};
> +
>  static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>  	.soc_type = QCA_WCN6750,
>  	.vregs = (struct qca_vreg []) {
> @@ -2179,6 +2204,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
> +	case QCA_QCA6698:
>  		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>  		msleep(100);
>  		qca_regulator_disable(qcadev);
> @@ -2333,6 +2359,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
>  	case QCA_QCA6390:
> +	case QCA_QCA6698:
>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>  						sizeof(struct qca_power),
>  						GFP_KERNEL);
> @@ -2346,6 +2373,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the
> @@ -2380,7 +2408,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  					       GPIOD_OUT_LOW);
>  		if (IS_ERR(qcadev->bt_en) &&
>  		    (data->soc_type == QCA_WCN6750 ||
> -		     data->soc_type == QCA_WCN6855)) {
> +		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_QCA6698)) {
>  			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>  			return PTR_ERR(qcadev->bt_en);
>  		}
> @@ -2393,7 +2422,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		if (IS_ERR(qcadev->sw_ctrl) &&
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855 ||
> -		     data->soc_type == QCA_WCN7850)) {
> +		     data->soc_type == QCA_WCN7850 ||
> +		     data->soc_type == QCA_QCA6698)) {
>  			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>  			return PTR_ERR(qcadev->sw_ctrl);
>  		}
> @@ -2475,6 +2505,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6698:
>  		if (power->vregs_on)
>  			qca_power_shutdown(&qcadev->serdev_hu);
>  		break;
> @@ -2669,6 +2700,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
>  	{ .compatible = "qcom,qca6174-bt" },
>  	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
> +	{ .compatible = "qcom,qca6698-bt", .data = &qca_soc_data_qca6698},
>  	{ .compatible = "qcom,qca9377-bt" },
>  	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

