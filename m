Return-Path: <linux-kernel+bounces-434616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E859E68FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1591617F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100511DDA3A;
	Fri,  6 Dec 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUARV8Jr"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A71DDC01
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474059; cv=none; b=eIvaUqGzrVGsk7XWVjUWz9bn1B5YO6LMbjco/fUHHjl48GNWjSS5SB1WC0USM5JVu7nYBxoL+lBR/pRQgkNq0Pf+aZZQhTYlz8ngzgz8s0qC+UdpHoXd/EV1PGC70Jc/tUBAhneMOpNByNYUbbKgA+C2faNgoMuQYwXR1hb17qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474059; c=relaxed/simple;
	bh=CzvxH9gkJxMLDmcJg1PiYkIsVIuRDkUPYM3JYP9Eedk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5N/Iy8oZyvaJG4wCkt4sC2vnh+Ja6AQlTNVXI4MYYjpzSYW0dXiwBsRMTHDO0i2LiRczY1CvaMiQt9ogYUdSb7AfVqI9eSr2doCCdRletM+7sZBYSYfXLo0aFR22Um9Yj5i2fUH55hckwlfd6FdyfimhkW+tAVD7pjD4+HnrP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUARV8Jr; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3985aabf43so1580582276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474055; x=1734078855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXKgcEVb1fAZ9PQ6roP5n37uMrfa9dLkMGVwoJG+NRE=;
        b=vUARV8JrtoMRQ9wVbILF9ZRta5mKFf9m7Cgt850glTBM57GgbNKCJhtTenWef8Us92
         0NAp6hx8Z3xIVGII1/M1Zri5sv7VQ0Bi91wc2ejIsFTpeiNoBX/h7Fp0tkExQDpF0ODq
         I5uyN6QX+4GBY1SxA2kXk35hjB1U38N+xkhB3Gp6Fgzq+68Mn2OwiuN+fEex3pmJVZpV
         T/QbzruZB2Rm+hFD9FCX2txgjfH2KHTDvB4L5lXMC1J3QXb8i/ojZfTDYNgsW7i+3IxL
         J62AHAZzMnr2Oq3YKH+/gGhio2E0j9Rv0qmt2ngqGbgxHBKrsqIGkSpYHdUJ1EtxYJT1
         6/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474055; x=1734078855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXKgcEVb1fAZ9PQ6roP5n37uMrfa9dLkMGVwoJG+NRE=;
        b=KG979qgj+1d6nPN+k3SIWrIDftA7YuCCJcTtpbO0/swSXd1HoN8kxVF2OCZz+0w283
         qrHT7oe4ZS9gN2PYGPadvsmRie+g7mHq52jkwLfG+X2oeUbDCTLUKttsii54//O7WUt9
         HARua/0r5zMJ0DH0pAS2Y7DeCeGkIfZgiMTld5LfuudH5xu2oVDUVg8L8GwSiQlSC956
         +gnVzFQ3GDolyZsS9jxLPAyvBzyIhD4auzojxyNUUjuv08MRHnKx5GRULEkPIOt5Ryy0
         /ufi3jqS5YqGjb4BWsFY5q4YT1Cjt5WovzNNpcxwzhSfDQ9HO463NfKdCFBiwRdbTen8
         iP9w==
X-Forwarded-Encrypted: i=1; AJvYcCW7tC728DZBvub5xO3tmYSdrgAGhAv1kaqea5Rev1BjGzyNbwHZNt8xzsUBXX4OB2VOv+PR0vfHKRrzia0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVyWYlJnXhL8o7KIpzx6Lx6sg/dY+PPnMSWDKqqVBbaSkSWSF
	UH06El7gcIKpXqcZ9C0OYEogL0PiUgrYlrg3Ys1qjmxCxVi3M9LhhYei3+eZV1Z6DyTk4UZfCPK
	r+6j7oB7zSroHxApHyTvjAwwpo0/9AmVZtOR2/A==
X-Gm-Gg: ASbGncua13WqHj2Rbd8TnTV9zCJ38jbjlhcgqFS7Fc6HD46L4VKVaw111kxb9vKV4bX
	PGfxBdXkV52SGFlwGDn0WxqdFGCPanl14TvyktW+EsMZatw==
X-Google-Smtp-Source: AGHT+IHyXduCRkh45D5lh25sBvKIj/KnqB4qNNwNbS/p4VvHcYUsVzvbtMEVOSG9sGkzLNoSmyaf4A1tpaHlx/4QtSA=
X-Received: by 2002:a05:6902:c11:b0:e39:9853:e661 with SMTP id
 3f1490d57ef6-e3a0b13324emr1756773276.26.1733474055019; Fri, 06 Dec 2024
 00:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205102213.1281865-1-quic_chejiang@quicinc.com>
 <20241205102213.1281865-3-quic_chejiang@quicinc.com> <w7r4itwyrh3jva3rx3kmsm4kqtawqkgkneqrlin4hpjkqb3deo@2qmjd3ijzqn3>
 <541a5682-5b99-4793-84ee-a7c9168cb9a0@quicinc.com>
In-Reply-To: <541a5682-5b99-4793-84ee-a7c9168cb9a0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 6 Dec 2024 10:34:04 +0200
Message-ID: <CAA8EJppmTSovZKTPb+syrc0Vvfu8U=HoP18tW072OEZ5nYyOgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Bluetooth: qca: Expand firmware-name to load
 specific nvm and rampatch
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, quic_zijuhu@quicinc.com, 
	quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 05:05, Cheng Jiang (IOE)
<quic_chejiang@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 12/5/2024 8:00 PM, Dmitry Baryshkov wrote:
> > On Thu, Dec 05, 2024 at 06:22:12PM +0800, Cheng Jiang wrote:
> >> The firmware-name property has been expanded to specify the names of NVM
> >> and rampatch firmware for certain chips, such as the QCA6698 Bluetooth
> >> chip. Although it shares the same IP core as the WCN6855, the QCA6698
> >> has different RF components and RAM sizes, necessitating new firmware
> >> files. This change allows for the configuration of NVM and rampatch in
> >> DT.
> >>
> >> Different connectivity boards may be attached to the same platform. For
> >> example, QCA6698-based boards can support either a two-antenna or
> >> three-antenna solution, both of which work on the sa8775p-ride platform.
> >> Due to differences in connectivity boards and variations in RF
> >> performance from different foundries, different NVM configurations are
> >> used based on the board ID.
> >
> > Two separate commits, one for NVM, another one for RAM patch.
> >
> Ack.
> >>
> >> Therefore, in the firmware-name property, if the NVM file has an
> >> extension, the NVM file will be used. Otherwise, the system will first
> >> try the .bNN (board ID) file, and if that fails, it will fall back to
> >> the .bin file.
> >>
> >> Possible configurations:
> >> firmware-name = "QCA6698/hpnv21.bin", "QCA6698/hpbtfw21.tlv";
> >> firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
> >> firmware-name = "QCA6698/hpnv21.bin";
> >>
> >> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >> ---
> >>  drivers/bluetooth/btqca.c   | 154 ++++++++++++++++++++++++++----------
> >>  drivers/bluetooth/btqca.h   |   5 +-
> >>  drivers/bluetooth/hci_qca.c |  21 ++++-
> >>  3 files changed, 134 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> >> index dfbbac922..e8b89b8cc 100644
> >> --- a/drivers/bluetooth/btqca.c
> >> +++ b/drivers/bluetooth/btqca.c
> >> @@ -272,6 +272,31 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
> >>  }
> >>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
> >>
> >> +static int qca_get_alt_nvm_path(char *path, size_t max_size)
> >
> > int is usually for errors, the code suggests bool return type.
> >
> Ack.
> >> +{
> >> +    char fwname[64];
> >> +    const char *suffix;
> >> +
> >> +    suffix = strrchr(path, '.');
> >> +
> >> +    if (!suffix)
> >> +            return 0;
> >> +
> >> +    strscpy(fwname, path, strlen(path));
> >
> > 64 bytes ought to be enough for anybody, correct?
> >
> Yes, in current driver, the max f/w path length is 64.
>
> >> +    fwname[suffix - path] = 0;
> >
> > with path = "qcom/sc7180/Oh.My.Device/name" this is broken.
> >
> Let me test this and fix in next patch.
> >> +
> >> +    snprintf(fwname, sizeof(fwname), "%s.bin", fwname);
> >> +
> >> +    /* If nvm file is already the default one, return false to
> >> +     * skip the retry.
> >> +     */
> >> +    if (strcmp(fwname, path) == 0)
> >> +            return 0;
> >> +
> >> +    snprintf(path, max_size, "%s", fwname);
> >> +    return 1;
> >> +}
> >> +
> >>  static int qca_tlv_check_data(struct hci_dev *hdev,
> >>                             struct qca_fw_config *config,
> >>                             u8 *fw_data, size_t fw_size,
> >> @@ -564,6 +589,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
> >>                                         config->fwname, ret);
> >>                              return ret;
> >>                      }
> >> +            }
> >> +            /* For nvm, if desired nvm file is not present and it's not the
> >> +             * default nvm file(ends with .bin), try to load the default nvm.
> >> +             */
> >> +            else if (config->type == TLV_TYPE_NVM &&
> >> +                     qca_get_alt_nvm_path(config->fwname, sizeof(config->fwname))) {
> >
> > Please, don't rewrite the config. The file may be not present now, but
> > it will reappear later (e.g. when rootfs gets mounted).
> >
> This tries to load a default NVM file if the board-specific NVM is not found.
> It is called when request_firmware fails. It's safe to rewrite the config->fwname
> here since we have already tried to load the board-specific NVM. The config
> is a local variable in qca_uart_setup and will return after downloading the NVM.

Please read my question before answering it.

> >> +                    bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> >> +                    ret = request_firmware(&fw, config->fwname, &hdev->dev);
> >> +                    if (ret) {
> >> +                            bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> >> +                                       config->fwname, ret);
> >> +                            return ret;
> >> +                    }
> >>              } else {
> >>                      bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> >>                                 config->fwname, ret);
> >> @@ -730,15 +768,38 @@ static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
> >>                       "qca/%snv%02x.b%02x", stem, rom_ver, bid);
> >>  }
> >>
> >> +static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
> >> +            const char *firmware_name, struct qca_btsoc_version ver,
> >> +            enum qca_btsoc_type soc_type, u16 bid)
> >> +{
> >> +    const char *variant;
> >> +
> >> +    /* Set the variant to empty by default */
> >> +    variant = "";
> >> +    /* hsp gf chip */
> >> +    if (soc_type == QCA_WCN6855) {
> >> +            if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> >> +                    variant = "g";
> >
> > Didn't you get the 'set but unused' here?
> >
> Yes, miss this part. Thank you!
> >> +    }
> >> +
> >> +    if (bid == 0x0)
> >
> > 0x0 or 0xff?
> board is set to 0 by default, 0x0 means read board id fails, then we should use
> the default one.

What is the 'unprogrammed' board_id? On the WiFi side it's usually 0xff.

> >
> >> +            snprintf(fwname, max_size, "qca/%s.bin", firmware_name);
> >> +    else if (bid & 0xff00)
> >> +            snprintf(fwname, max_size, "qca/%s.b%x", firmware_name, bid);
> >
> > Doesn't ".b%02x" work in this case too?
> >
> No, board id are two bytes, it coudl be 0x0206, then we need .b206. Or it is
> 0x000a, then we need .b0a.

What will ".b%02x" write in those two cases?

> >> +    else
> >> +            snprintf(fwname, max_size, "qca/%s.b%02x", firmware_name, bid);
> >> +}
> >> +


-- 
With best wishes
Dmitry

