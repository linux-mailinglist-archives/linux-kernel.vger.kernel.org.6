Return-Path: <linux-kernel+bounces-528457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8DA417DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9433AE668
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF023F43C;
	Mon, 24 Feb 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlrwlnoO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1D23A571
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387220; cv=none; b=NCQCb2oTUucn5n4s014J8UyAhuSgY+LcB/Q0E+0ytwABDARTRnYgwmlFgq8d4QFovKO6/qN13zY78XM4B8myuiRvNCqCvOf2x+SFdjXmHfPjUWL14k11pZsZhAjE+UsvEPyiOm4l0dG609Zuqrt5mIGOT5JjihpXMQe4IApfDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387220; c=relaxed/simple;
	bh=TBBuFIXkek4LQaS/qrgXgGandHdrL7/svLyzvD9TRlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB6ikRAtWlJJ46yrgrjnzRgt4L9QqYQ2CfxU+DXn65EjCCK2WlJ7lG2uezOMgOru3pHqK/LYwg5ZvwX6O53eOZwH99VosdvI1Z6iKYnW0xsBSdRPIOh3OX45jP8HZCNGz4WW7R44jqREMEflCOTnnlf5omPDSz6CEr8YmWBoeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlrwlnoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740387217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PFJ4hYUNKFZH5hCU9Ec8BfurWYang2c60hlO6sAPeE=;
	b=NlrwlnoOYoOdRcADHFlxkPn01OCBm2fYhT+AsF5f9sYb2Zqns9ZLfsSF+wg2QIJK9Gg1kR
	qk28hvTH3lmbB4SVSQ7t0hsbHKG6SSWJvb4DmrbpaWiIpbHK+Bgj/HjS2QhTlStPyIKUGp
	bL9XWQHvGAyUj1lV9kdNBQWs/REEOyc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-I9B85DElMM6Cn9holeNLDw-1; Mon, 24 Feb 2025 03:53:31 -0500
X-MC-Unique: I9B85DElMM6Cn9holeNLDw-1
X-Mimecast-MFC-AGG-ID: I9B85DElMM6Cn9holeNLDw_1740387210
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbae81829fso484677366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387210; x=1740992010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PFJ4hYUNKFZH5hCU9Ec8BfurWYang2c60hlO6sAPeE=;
        b=LzmHASmv5U8pgIXBtx2uc+It2/qUfbkPBw69+LN/x3UL7BRa1+ZHXYqT/WgrdVtCKH
         gLB9Pg4X6DDTn5oUXCGyzyzmrxRFYbi5zLlwprGBPhbwGCV6fKYeCv99F+wChJ/haitr
         HzA3AD/7O7vWhlvjX6eEQgWQXX0455SmWhQo3SHEe2InWhjBPQrNI3w5uMzsNGoY6EKy
         VpGUMgXlWN5+/RcPyBBA4GnqhpQ7tHpMHjwcUhVcPfJk6KWJpHSFl6MhV811Pah9hGfC
         9ya7AErRMG2xnt5zEPH/UKtPxbwMDCr1ABvlwhIuIHDUXn40U8NDDwSZApfL74YmdAZV
         +fmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkK+uxNSYe7+AtFNCZC3x8I8p2btuN8bbAFUN8PS5ytkWTRkx4+ggTnmFJ3h6laMjAyyCMyOMJah7ZSV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMyWtQ8UJkMhI+9lUNmXjsDDFWfqkkaHXPNfYFbvW7hoCZado
	dNTXpffkizOSYRJcM8vcFb7iNtw0DeaRB3Ops4dPhWOQJPEpQYORlyhwDU0cu84AhwOCERjNg5t
	TIfbj2m6G3oF+f+x94vrjfrWV1dRblRhkWxHWc3csX2585FOfvq/jxXwGaSkGYA==
X-Gm-Gg: ASbGncsYxmYahvBBAVQ+83H/PNRDh8DPsqn7IUs3Mc9uO5cKTU9giqvUBl4R6WYNl3T
	NyvlA4dLPfsGagOw8agJhmGfndG7yZqYdwS5dvdyQAmOhTJfOu8s6Q1z8UeCvfWwhSRdK5Qsvgn
	M1AiHOrtXoZFXAJop4hc+M0JoLcnhC3R/4AHwOkTTVbTjwDy2rOtbgsoMy7WrejuuQAcO0SyXCG
	EOmfdH4/wNxVrC4SiqjFlpfo2X/4QdG1SuvtrfczVctBuP1/xsi8AfacDAbD6EI+uVIUCAYRqlV
	RWshKi0iZJfwulswT4z2qpwteOX+AVetp/PEaVqP/z0fu5CBGBk1C+ufMvwHz64th3sSZSpJTeQ
	OIdJSN9I3Xpx9FUalpOse4YH31NSf+K3Sy/+PzjwBZHzq1e1RmzX8WBWZX4xQOBBYow==
X-Received: by 2002:a05:6402:2688:b0:5d1:f009:925e with SMTP id 4fb4d7f45d1cf-5e0b7104037mr12540991a12.16.1740387209856;
        Mon, 24 Feb 2025 00:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuedJ+E5P1JkDrWL8YCYCxixo2VcRhK3j4W+/yHmKBfKNqoBtHqym9gbqEWsEq/UcMnuR7YQ==
X-Received: by 2002:a05:6402:2688:b0:5d1:f009:925e with SMTP id 4fb4d7f45d1cf-5e0b7104037mr12540949a12.16.1740387209037;
        Mon, 24 Feb 2025 00:53:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ded69e7c33sm17063270a12.61.2025.02.24.00.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:53:27 -0800 (PST)
Message-ID: <7941262f-6a12-4c29-857f-bc8363686008@redhat.com>
Date: Mon, 24 Feb 2025 09:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8723bs: Remove some unused functions, macros,
 and structs
To: Yeking@Red54.com
Cc: arnd@arndb.de, dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
 johannes.berg@intel.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 masahiroy@kernel.org, nicolas@fjasle.eu, philipp.g.hortmann@gmail.com,
 rodrigo.gobbi.7@gmail.com, Roshan Khatri <topofeverest8848@gmail.com>
References: <tencent_202D558F9075C15FCD33573BC88F48E03706@qq.com>
 <tencent_C69BFF8D3EC7B66BFCF0063ED3DEF4BC590A@qq.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <tencent_C69BFF8D3EC7B66BFCF0063ED3DEF4BC590A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 22-Feb-25 8:03 PM, Yeking@Red54.com wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> Remove some functions, macros, and structs that have not been used since
> they were introduced in commit 554c0a3abf21 ("staging: Add rtl8723bs
> sdio wifi driver").
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/hal/hal_com.c       |   3 +
>  .../staging/rtl8723bs/include/osdep_intf.h    |  27 --
>  .../staging/rtl8723bs/include/rtl8723b_hal.h  |   1 -
>  drivers/staging/rtl8723bs/include/rtw_io.h    |  92 -----
>  drivers/staging/rtl8723bs/include/rtw_mp.h    | 341 ------------------
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   2 -
>  6 files changed, 3 insertions(+), 463 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/include/rtw_mp.h
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index b41ec89932af..1213a91cffff 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -884,6 +884,9 @@ static u32 Array_kfreemap[] = {
>  	0xfc, 0x0,
>  };
>  
> +#define		REG_RF_BB_GAIN_OFFSET	0x7f
> +//#define		RF_GAIN_OFFSET_MASK	0xfffff
> +
>  void rtw_bb_rf_gain_offset(struct adapter *padapter)
>  {
>  	u8 value = padapter->eeprompriv.EEPROMRFGainOffset;
> diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
> index 73199be78139..83a25598e962 100644
> --- a/drivers/staging/rtl8723bs/include/osdep_intf.h
> +++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
> @@ -8,33 +8,6 @@
>  #ifndef __OSDEP_INTF_H_
>  #define __OSDEP_INTF_H_
>  
> -
> -struct intf_priv {
> -
> -	u8 *intf_dev;
> -	u32 max_iosz;	/* USB2.0: 128, USB1.1: 64, SDIO:64 */
> -	u32 max_xmitsz; /* USB2.0: unlimited, SDIO:512 */
> -	u32 max_recvsz; /* USB2.0: unlimited, SDIO:512 */
> -
> -	volatile u8 *io_rwmem;
> -	volatile u8 *allocated_io_rwmem;
> -	u32 io_wsz; /* unit: 4bytes */
> -	u32 io_rsz;/* unit: 4bytes */
> -	u8 intf_status;
> -
> -	void (*_bus_io)(u8 *priv);
> -
> -/*
> -Under Sync. IRP (SDIO/USB)
> -A protection mechanism is necessary for the io_rwmem(read/write protocol)
> -
> -Under Async. IRP (SDIO/USB)
> -The protection mechanism is through the pending queue.
> -*/
> -
> -	struct mutex ioctl_mutex;
> -};
> -
>  struct dvobj_priv *devobj_init(void);
>  void devobj_deinit(struct dvobj_priv *pdvobj);
>  
> diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
> index e6d6e9de5474..a4a14474c35d 100644
> --- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
> +++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
> @@ -15,7 +15,6 @@
>  #include "rtl8723b_recv.h"
>  #include "rtl8723b_xmit.h"
>  #include "rtl8723b_cmd.h"
> -#include "rtw_mp.h"
>  #include "hal_pwr_seq.h"
>  #include "Hal8192CPhyReg.h"
>  #include "hal_phy_cfg.h"
> diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
> index 0ee87be6dc4f..adf1de4d7924 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_io.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_io.h
> @@ -8,16 +8,7 @@
>  #ifndef _RTW_IO_H_
>  #define _RTW_IO_H_
>  
> -/*
> -	For prompt mode accessing, caller shall free io_req
> -	Otherwise, io_handler will free io_req
> -*/
> -
> -/* below is for the intf_option bit definition... */
> -
> -struct intf_priv;
>  struct intf_hdl;
> -struct io_queue;
>  
>  struct _io_ops {
>  		u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
> @@ -36,8 +27,6 @@ struct _io_ops {
>  		void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
>  		void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
>  
> -		void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
> -
>  		u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
>  
>  		u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> @@ -49,18 +38,6 @@ struct _io_ops {
>  		void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
>  };
>  
> -struct io_req {
> -	struct list_head	list;
> -	u32 addr;
> -	volatile u32 val;
> -	u32 command;
> -	u32 status;
> -	u8 *pbuf;
> -
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt);
> -	u8 *cnxt;
> -};
> -
>  struct	intf_hdl {
>  	struct adapter *padapter;
>  	struct dvobj_priv *pintf_dev;/* 	pointer to &(padapter->dvobjpriv); */
> @@ -74,21 +51,6 @@ struct	intf_hdl {
>  int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj);
>  void rtw_reset_continual_io_error(struct dvobj_priv *dvobj);
>  
> -/*
> -Below is the data structure used by _io_handler
> -
> -*/
> -
> -struct io_queue {
> -	spinlock_t	lock;
> -	struct list_head	free_ioreqs;
> -	struct list_head		pending;		/* The io_req list that will be served in the single protocol read/write. */
> -	struct list_head		processing;
> -	u8 *free_ioreqs_buf; /*  4-byte aligned */
> -	u8 *pallocated_free_ioreqs_buf;
> -	struct	intf_hdl	intf;
> -};
> -
>  struct io_priv {
>  
>  	struct adapter *padapter;
> @@ -97,20 +59,6 @@ struct io_priv {
>  
>  };
>  
> -extern uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
> -extern void sync_ioreq_enqueue(struct io_req *preq, struct io_queue *ioqueue);
> -extern uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
> -
> -
> -extern uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
> -extern struct io_req *alloc_ioreq(struct io_queue *pio_q);
> -
> -extern uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
> -extern void unregister_intf_hdl(struct intf_hdl *pintfhdl);
> -
> -extern void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -extern void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -
>  extern u8 rtw_read8(struct adapter *adapter, u32 addr);
>  extern u16 rtw_read16(struct adapter *adapter, u32 addr);
>  extern u32 rtw_read32(struct adapter *adapter, u32 addr);
> @@ -121,46 +69,6 @@ extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
>  
>  extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>  
> -extern void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
> -
> -/* ioreq */
> -extern void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
> -extern void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
> -extern void ioreq_read32(struct adapter *adapter, u32 addr, u32 *pval);
> -extern void ioreq_write8(struct adapter *adapter, u32 addr, u8 val);
> -extern void ioreq_write16(struct adapter *adapter, u32 addr, u16 val);
> -extern void ioreq_write32(struct adapter *adapter, u32 addr, u32 val);
> -
> -
> -extern uint async_read8(struct adapter *adapter, u32 addr, u8 *pbuff,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -extern uint async_read16(struct adapter *adapter, u32 addr,  u8 *pbuff,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -extern uint async_read32(struct adapter *adapter, u32 addr,  u8 *pbuff,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -
> -extern void async_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -extern void async_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -
> -extern void async_write8(struct adapter *adapter, u32 addr, u8 val,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -extern void async_write16(struct adapter *adapter, u32 addr, u16 val,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -extern void async_write32(struct adapter *adapter, u32 addr, u32 val,
> -	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
> -
> -extern void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -extern void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -
> -
>  int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapter *padapter, struct _io_ops *pops));
>  
> -
> -extern uint alloc_io_queue(struct adapter *adapter);
> -extern void free_io_queue(struct adapter *adapter);
> -extern void async_bus_io(struct io_queue *pio_q);
> -extern void bus_sync_io(struct io_queue *pio_q);
> -extern u32 _ioreq2rwmem(struct io_queue *pio_q);
> -extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);
> -
>  #endif	/* _RTL8711_IO_H_ */
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
> deleted file mode 100644
> index 5a1cbd2ed851..000000000000
> --- a/drivers/staging/rtl8723bs/include/rtw_mp.h
> +++ /dev/null
> @@ -1,341 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/******************************************************************************
> - *
> - * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
> - *
> - ******************************************************************************/
> -#ifndef _RTW_MP_H_
> -#define _RTW_MP_H_
> -
> -#define MAX_MP_XMITBUF_SZ	2048
> -
> -struct mp_xmit_frame {
> -	struct list_head	list;
> -
> -	struct pkt_attrib attrib;
> -
> -	struct sk_buff *pkt;
> -
> -	int frame_tag;
> -
> -	struct adapter *padapter;
> -
> -	uint mem[(MAX_MP_XMITBUF_SZ >> 2)];
> -};
> -
> -struct mp_wiparam {
> -	u32 bcompleted;
> -	u32 act_type;
> -	u32 io_offset;
> -	u32 io_value;
> -};
> -
> -struct mp_tx {
> -	u8 stop;
> -	u32 count, sended;
> -	u8 payload;
> -	struct pkt_attrib attrib;
> -	/* struct tx_desc desc; */
> -	/* u8 resvdtx[7]; */
> -	u8 desc[TXDESC_SIZE];
> -	u8 *pallocated_buf;
> -	u8 *buf;
> -	u32 buf_size, write_size;
> -	void *PktTxThread;
> -};
> -
> -#define MP_MAX_LINES		1000
> -#define MP_MAX_LINES_BYTES	256
> -
> -typedef void (*MPT_WORK_ITEM_HANDLER)(void *Adapter);
> -struct mpt_context {
> -	/*  Indicate if we have started Mass Production Test. */
> -	bool			bMassProdTest;
> -
> -	/*  Indicate if the driver is unloading or unloaded. */
> -	bool			bMptDrvUnload;
> -
> -	struct timer_list			MPh2c_timeout_timer;
> -/*  Event used to sync H2c for BT control */
> -
> -	bool		MptH2cRspEvent;
> -	bool		MptBtC2hEvent;
> -	bool		bMPh2c_timeout;
> -
> -	/* 8190 PCI does not support NDIS_WORK_ITEM. */
> -	/*  Work Item for Mass Production Test. */
> -	/* NDIS_WORK_ITEM	MptWorkItem; */
> -/* 	RT_WORK_ITEM		MptWorkItem; */
> -	/*  Event used to sync the case unloading driver and MptWorkItem is still in progress. */
> -/* 	NDIS_EVENT		MptWorkItemEvent; */
> -	/*  To protect the following variables. */
> -/* 	NDIS_SPIN_LOCK		MptWorkItemSpinLock; */
> -	/*  Indicate a MptWorkItem is scheduled and not yet finished. */
> -	bool			bMptWorkItemInProgress;
> -	/*  An instance which implements function and context of MptWorkItem. */
> -	MPT_WORK_ITEM_HANDLER	CurrMptAct;
> -
> -	/*  1 =Start, 0 =Stop from UI. */
> -	u32 		MptTestStart;
> -	/*  _TEST_MODE, defined in MPT_Req2.h */
> -	u32 		MptTestItem;
> -	/*  Variable needed in each implementation of CurrMptAct. */
> -	u32 		MptActType;	/*  Type of action performed in CurrMptAct. */
> -	/*  The Offset of IO operation is depend of MptActType. */
> -	u32 		MptIoOffset;
> -	/*  The Value of IO operation is depend of MptActType. */
> -	u32 		MptIoValue;
> -	/*  The RfPath of IO operation is depend of MptActType. */
> -	u32 		MptRfPath;
> -
> -	enum wireless_mode		MptWirelessModeToSw;	/*  Wireless mode to switch. */
> -	u8 	MptChannelToSw;		/*  Channel to switch. */
> -	u8 	MptInitGainToSet;	/*  Initial gain to set. */
> -	u32 		MptBandWidth;		/*  bandwidth to switch. */
> -	u32 		MptRateIndex;		/*  rate index. */
> -	/*  Register value kept for Single Carrier Tx test. */
> -	u8 	btMpCckTxPower;
> -	/*  Register value kept for Single Carrier Tx test. */
> -	u8 	btMpOfdmTxPower;
> -	/*  For MP Tx Power index */
> -	u8 	TxPwrLevel[2];	/*  rf-A, rf-B */
> -	u32 		RegTxPwrLimit;
> -	/*  Content of RCR Register for Mass Production Test. */
> -	u32 		MptRCR;
> -	/*  true if we only receive packets with specific pattern. */
> -	bool			bMptFilterPattern;
> -	/*  Rx OK count, statistics used in Mass Production Test. */
> -	u32 		MptRxOkCnt;
> -	/*  Rx CRC32 error count, statistics used in Mass Production Test. */
> -	u32 		MptRxCrcErrCnt;
> -
> -	bool			bCckContTx;	/*  true if we are in CCK Continuous Tx test. */
> -	bool			bOfdmContTx;	/*  true if we are in OFDM Continuous Tx test. */
> -	bool			bStartContTx;	/*  true if we have start Continuous Tx test. */
> -	/*  true if we are in Single Carrier Tx test. */
> -	bool			bSingleCarrier;
> -	/*  true if we are in Carrier Suppression Tx Test. */
> -	bool			bCarrierSuppression;
> -	/* true if we are in Single Tone Tx test. */
> -	bool			bSingleTone;
> -
> -	/*  ACK counter asked by K.Y.. */
> -	bool			bMptEnableAckCounter;
> -	u32 		MptAckCounter;
> -
> -	/*  SD3 Willis For 8192S to save 1T/2T RF table for ACUT	Only fro ACUT delete later ~~~! */
> -	/* s8		BufOfLines[2][MAX_LINES_HWCONFIG_TXT][MAX_BYTES_LINE_HWCONFIG_TXT]; */
> -	/* s8			BufOfLines[2][MP_MAX_LINES][MP_MAX_LINES_BYTES]; */
> -	/* s32			RfReadLine[2]; */
> -
> -	u8 APK_bound[2];	/* for APK	path A/path B */
> -	bool		bMptIndexEven;
> -
> -	u8 backup0xc50;
> -	u8 backup0xc58;
> -	u8 backup0xc30;
> -	u8 backup0x52_RF_A;
> -	u8 backup0x52_RF_B;
> -
> -	u32 		backup0x58_RF_A;
> -	u32 		backup0x58_RF_B;
> -
> -	u8 	h2cReqNum;
> -	u8 	c2hBuf[32];
> -
> -    u8          btInBuf[100];
> -	u32 		mptOutLen;
> -    u8          mptOutBuf[100];
> -
> -};
> -/* endif */
> -
> -/* define RTPRIV_IOCTL_MP					(SIOCIWFIRSTPRIV + 0x17) */
> -enum {
> -	WRITE_REG = 1,
> -	READ_REG,
> -	WRITE_RF,
> -	READ_RF,
> -	MP_START,
> -	MP_STOP,
> -	MP_RATE,
> -	MP_CHANNEL,
> -	MP_BANDWIDTH,
> -	MP_TXPOWER,
> -	MP_ANT_TX,
> -	MP_ANT_RX,
> -	MP_CTX,
> -	MP_QUERY,
> -	MP_ARX,
> -	MP_PSD,
> -	MP_PWRTRK,
> -	MP_THER,
> -	MP_IOCTL,
> -	EFUSE_GET,
> -	EFUSE_SET,
> -	MP_RESET_STATS,
> -	MP_DUMP,
> -	MP_PHYPARA,
> -	MP_SetRFPathSwh,
> -	MP_QueryDrvStats,
> -	MP_SetBT,
> -	CTA_TEST,
> -	MP_DISABLE_BT_COEXIST,
> -	MP_PwrCtlDM,
> -	MP_NULL,
> -	MP_GET_TXPOWER_INX,
> -};
> -
> -struct mp_priv {
> -	struct adapter *papdater;
> -
> -	/* Testing Flag */
> -	u32 mode;/* 0 for normal type packet, 1 for loopback packet (16bytes TXCMD) */
> -
> -	u32 prev_fw_state;
> -
> -	/* OID cmd handler */
> -	struct mp_wiparam workparam;
> -/* 	u8 act_in_progress; */
> -
> -	/* Tx Section */
> -	u8 TID;
> -	u32 tx_pktcount;
> -	u32 pktInterval;
> -	struct mp_tx tx;
> -
> -	/* Rx Section */
> -	u32 rx_bssidpktcount;
> -	u32 rx_pktcount;
> -	u32 rx_pktcount_filter_out;
> -	u32 rx_crcerrpktcount;
> -	u32 rx_pktloss;
> -	bool  rx_bindicatePkt;
> -	struct recv_stat rxstat;
> -
> -	/* RF/BB relative */
> -	u8 channel;
> -	u8 bandwidth;
> -	u8 prime_channel_offset;
> -	u8 txpoweridx;
> -	u8 txpoweridx_b;
> -	u8 rateidx;
> -	u32 preamble;
> -/* 	u8 modem; */
> -	u32 CrystalCap;
> -/* 	u32 curr_crystalcap; */
> -
> -	u16 antenna_tx;
> -	u16 antenna_rx;
> -/* 	u8 curr_rfpath; */
> -
> -	u8 check_mp_pkt;
> -
> -	u8 bSetTxPower;
> -/* 	uint ForcedDataRate; */
> -	u8 mp_dm;
> -	u8 mac_filter[ETH_ALEN];
> -	u8 bmac_filter;
> -
> -	struct wlan_network mp_network;
> -	NDIS_802_11_MAC_ADDRESS network_macaddr;
> -
> -	u8 *pallocated_mp_xmitframe_buf;
> -	u8 *pmp_xmtframe_buf;
> -	struct __queue free_mp_xmitqueue;
> -	u32 free_mp_xmitframe_cnt;
> -	bool bSetRxBssid;
> -	bool bTxBufCkFail;
> -
> -	struct mpt_context MptCtx;
> -
> -	u8 *TXradomBuffer;
> -};
> -
> -/* Hardware Registers */
> -extern u8 mpdatarate[NumRates];
> -
> -#define MAX_TX_PWR_INDEX_N_MODE 64	/*  0x3F */
> -
> -#define		REG_RF_BB_GAIN_OFFSET	0x7f
> -#define		RF_GAIN_OFFSET_MASK	0xfffff
> -
> -/*  */
> -/* struct mp_xmit_frame *alloc_mp_xmitframe(struct mp_priv *pmp_priv); */
> -/* int free_mp_xmitframe(struct xmit_priv *pxmitpriv, struct mp_xmit_frame *pmp_xmitframe); */
> -
> -s32 init_mp_priv(struct adapter *padapter);
> -void free_mp_priv(struct mp_priv *pmp_priv);
> -s32 MPT_InitializeAdapter(struct adapter *padapter, u8 Channel);
> -void MPT_DeInitAdapter(struct adapter *padapter);
> -s32 mp_start_test(struct adapter *padapter);
> -void mp_stop_test(struct adapter *padapter);
> -
> -u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
> -void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
> -
> -u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
> -void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
> -
> -void SetChannel(struct adapter *padapter);
> -void SetBandwidth(struct adapter *padapter);
> -int SetTxPower(struct adapter *padapter);
> -void SetAntennaPathPower(struct adapter *padapter);
> -void SetDataRate(struct adapter *padapter);
> -
> -void SetAntenna(struct adapter *padapter);
> -
> -s32 SetThermalMeter(struct adapter *padapter, u8 target_ther);
> -void GetThermalMeter(struct adapter *padapter, u8 *value);
> -
> -void SetContinuousTx(struct adapter *padapter, u8 bStart);
> -void SetSingleCarrierTx(struct adapter *padapter, u8 bStart);
> -void SetSingleToneTx(struct adapter *padapter, u8 bStart);
> -void SetCarrierSuppressionTx(struct adapter *padapter, u8 bStart);
> -void PhySetTxPowerLevel(struct adapter *padapter);
> -
> -void fill_txdesc_for_mp(struct adapter *padapter, u8 *ptxdesc);
> -void SetPacketTx(struct adapter *padapter);
> -void SetPacketRx(struct adapter *padapter, u8 bStartRx);
> -
> -void ResetPhyRxPktCount(struct adapter *padapter);
> -u32 GetPhyRxPktReceived(struct adapter *padapter);
> -u32 GetPhyRxPktCRC32Error(struct adapter *padapter);
> -
> -s32	SetPowerTracking(struct adapter *padapter, u8 enable);
> -void GetPowerTracking(struct adapter *padapter, u8 *enable);
> -
> -u32 mp_query_psd(struct adapter *padapter, u8 *data);
> -
> -void Hal_SetAntenna(struct adapter *padapter);
> -void Hal_SetBandwidth(struct adapter *padapter);
> -
> -void Hal_SetTxPower(struct adapter *padapter);
> -void Hal_SetCarrierSuppressionTx(struct adapter *padapter, u8 bStart);
> -void Hal_SetSingleToneTx(struct adapter *padapter, u8 bStart);
> -void Hal_SetSingleCarrierTx(struct adapter *padapter, u8 bStart);
> -void Hal_SetContinuousTx(struct adapter *padapter, u8 bStart);
> -
> -void Hal_SetDataRate(struct adapter *padapter);
> -void Hal_SetChannel(struct adapter *padapter);
> -void Hal_SetAntennaPathPower(struct adapter *padapter);
> -s32 Hal_SetThermalMeter(struct adapter *padapter, u8 target_ther);
> -s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable);
> -void Hal_GetPowerTracking(struct adapter *padapter, u8 *enable);
> -void Hal_GetThermalMeter(struct adapter *padapter, u8 *value);
> -void Hal_mpt_SwitchRfSetting(struct adapter *padapter);
> -void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14);
> -void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *padapter, bool beven);
> -void Hal_SetCCKTxPower(struct adapter *padapter, u8 *TxPower);
> -void Hal_SetOFDMTxPower(struct adapter *padapter, u8 *TxPower);
> -void Hal_TriggerRFThermalMeter(struct adapter *padapter);
> -u8 Hal_ReadRFThermalMeter(struct adapter *padapter);
> -void Hal_SetCCKContinuousTx(struct adapter *padapter, u8 bStart);
> -void Hal_SetOFDMContinuousTx(struct adapter *padapter, u8 bStart);
> -void Hal_ProSetCrystalCap(struct adapter *padapter, u32 CrystalCapVal);
> -void MP_PHY_SetRFPathSwitch(struct adapter *padapter, bool bMain);
> -u32 mpt_ProQueryCalTxPower(struct adapter *padapter, u8 RfPath);
> -void MPT_PwrCtlDM(struct adapter *padapter, u32 bstart);
> -u8 MptToMgntRate(u32 MptRateIdx);
> -
> -#endif /* _RTW_MP_H_ */
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 738a601c55bb..de48c3454ab3 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -724,8 +724,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
>  
>  	rtw_free_mlme_priv(&padapter->mlmepriv);
>  
> -	/* free_io_queue(padapter); */
> -
>  	_rtw_free_xmit_priv(&padapter->xmitpriv);
>  
>  	_rtw_free_sta_priv(&padapter->stapriv); /* will free bcmc_stainfo here */


