Return-Path: <linux-kernel+bounces-527435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F57A40B24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B43ADBAD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA220F096;
	Sat, 22 Feb 2025 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hT//igMU"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77A18F2FC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251476; cv=none; b=nUDH9RQDH/zDzyZPazNW4DTV6tI53rUMf2IwsxSQrPe2JWwrmkG5nrJSVu2FUPv9udbMzMCz5z0H2sZVQvNA2V9QW+rl2xN/mumN2NWZ8EAk4eAYwiTtW64AkO/oBkp7q3EW9r9IeounJOS+ZCzTz4xsmyPjaSFsxwUdyuU8nwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251476; c=relaxed/simple;
	bh=EK+eCWRFrhK6gv6xqQcZGlUijwMhqYDmTiyf6LJhMo8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1BgfR2X2Vffqr9fbh8za8B+AtrMv4NPtDmKsr+bpH8JbKFB1AsBGBn/CDaDBGGFjO1opRxsVifFHdafpuvfLSJg6myRlwxS87jdaifiGGEq3BaTR1DfyXhQ78Esqyc89xnuK9DAfdAEkekiqj5H4+ANvyFcVZ5xk80TVjvSNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hT//igMU; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740251461; bh=d1xih4I/rIAN4sdJ9l4mz8zyR9LGB3oZcfxZHpm19lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hT//igMUxa9jcM8njwVnTuYwUCE4EJpU1V31ZuGE7Z24BglhbpuQTuia9eG7LUOG3
	 /RvpIAWXDICoLVWqOyLaiULnT7gBb7wtVdLH/KcniwSzOo4RpWf8m01/4oGu1P/U2A
	 YJ/TtaZe6Qu2kmfd+yW3LNImBZdHSiAJtahmRnwM=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 11126CB2; Sun, 23 Feb 2025 03:04:17 +0800
X-QQ-mid: xmsmtpt1740251057tgguhhjc9
Message-ID: <tencent_C69BFF8D3EC7B66BFCF0063ED3DEF4BC590A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+WRiqgYwfFsj+bhElXD2wWnfR5tgVL1OxhN6DoXpiCO/JVKCPo6
	 5SlBaJxBQNCIf8hFr9+YOCUpxGlIQLVC0icCiMDet9ml0ykBO3M1nMcrD+971q5RaH2CppfLzG/C
	 rzcNyaYZ/qCJUH72Hg+KvDHBl8QuqHY3NaaUYImXcewGtta5GQhvpHttfZq5wfrC7d0uXsiCA0k5
	 dVjujlvo7Jdu5KWDB1qgRsAaWV69J7hqaSOngxAGSKVqeECeYqz2qxOxD439gHehaf4nwme6dxtU
	 LS5bI5u33eh+2VbBG0t419tZun2rUNXNPUqQlV7EShIlxwW1EMof1QpPrrKJ2j6HF0tU8jsEYzrT
	 Y2gq4AZsJPUbVgWcNnuDwucgzEPb5gEBHuQaBvyd00BE7M899yaK0c4+yKZdur/8EEoBIjK4s1r5
	 IoaZ0HLrYhNphItL1A88Ae282BZlFN7K64Uqj72BdAYdXlDRmNulJRaQGDKlopeYQD7zSpBxDgbL
	 qgV6DvPqZkx6NK/u0ExxgeUK9gx/iiNdGPpR0dCUbjpBqDX9KVyMBK7Yd/A3riarGclueeWcn+b/
	 xQzhTlF1Pt1dtQAY24G0se7N8WNNOft1Z1EvERAb/oZ/KIei7BPyER7F3sqrFBAUakVt18aERUS6
	 yS64MYRjhJNeAR8buojTrySMv5LEGLC5Gwnmi1m3HVaHkmSFNMSHIVCc11iRhsMuYPypB95S16JX
	 tkPggYxdDcXcXZvxaJSdy1gSnkjd3Hf3z5qqUp4R0CqoexGxMhKFgV0YFIUw7351SY4HUa3UCzJL
	 fr+3NEGjDXkyFr5og+5E290QQap9cCgRExgCDnP57pSW06yRTiG3Bv5B85JHM6oa1CkMyE9qzZHT
	 LA9O4f5vikrpw0Fc7dkvLFMNvm1KADeKXnSYN2BYCR9/v5snxbqjkeB+eNynyrx2l0A8kdBL5j2I
	 pT1dc1k1K1+AZvxTAnftL6ti20p6L2xd7KssxNRu2OYUPbsjWjLQknkwyZYZetwk3AV+dyxX98xH
	 YP3m+Wt4voEyjdCapYK6xs1x5o/xY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: yeking@red54.com
Cc: arnd@arndb.de,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	johannes.berg@intel.com,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	masahiroy@kernel.org,
	nicolas@fjasle.eu,
	philipp.g.hortmann@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Roshan Khatri <topofeverest8848@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Remove some unused functions, macros, and structs
Date: Sat, 22 Feb 2025 19:03:45 +0000
X-OQ-MSGID: <20250222190345.389795-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_202D558F9075C15FCD33573BC88F48E03706@qq.com>
References: <tencent_202D558F9075C15FCD33573BC88F48E03706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

Remove some functions, macros, and structs that have not been used since
they were introduced in commit 554c0a3abf21 ("staging: Add rtl8723bs
sdio wifi driver").

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       |   3 +
 .../staging/rtl8723bs/include/osdep_intf.h    |  27 --
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |   1 -
 drivers/staging/rtl8723bs/include/rtw_io.h    |  92 -----
 drivers/staging/rtl8723bs/include/rtw_mp.h    | 341 ------------------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   2 -
 6 files changed, 3 insertions(+), 463 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_mp.h

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index b41ec89932af..1213a91cffff 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -884,6 +884,9 @@ static u32 Array_kfreemap[] = {
 	0xfc, 0x0,
 };
 
+#define		REG_RF_BB_GAIN_OFFSET	0x7f
+//#define		RF_GAIN_OFFSET_MASK	0xfffff
+
 void rtw_bb_rf_gain_offset(struct adapter *padapter)
 {
 	u8 value = padapter->eeprompriv.EEPROMRFGainOffset;
diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 73199be78139..83a25598e962 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -8,33 +8,6 @@
 #ifndef __OSDEP_INTF_H_
 #define __OSDEP_INTF_H_
 
-
-struct intf_priv {
-
-	u8 *intf_dev;
-	u32 max_iosz;	/* USB2.0: 128, USB1.1: 64, SDIO:64 */
-	u32 max_xmitsz; /* USB2.0: unlimited, SDIO:512 */
-	u32 max_recvsz; /* USB2.0: unlimited, SDIO:512 */
-
-	volatile u8 *io_rwmem;
-	volatile u8 *allocated_io_rwmem;
-	u32 io_wsz; /* unit: 4bytes */
-	u32 io_rsz;/* unit: 4bytes */
-	u8 intf_status;
-
-	void (*_bus_io)(u8 *priv);
-
-/*
-Under Sync. IRP (SDIO/USB)
-A protection mechanism is necessary for the io_rwmem(read/write protocol)
-
-Under Async. IRP (SDIO/USB)
-The protection mechanism is through the pending queue.
-*/
-
-	struct mutex ioctl_mutex;
-};
-
 struct dvobj_priv *devobj_init(void);
 void devobj_deinit(struct dvobj_priv *pdvobj);
 
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index e6d6e9de5474..a4a14474c35d 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -15,7 +15,6 @@
 #include "rtl8723b_recv.h"
 #include "rtl8723b_xmit.h"
 #include "rtl8723b_cmd.h"
-#include "rtw_mp.h"
 #include "hal_pwr_seq.h"
 #include "Hal8192CPhyReg.h"
 #include "hal_phy_cfg.h"
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index 0ee87be6dc4f..adf1de4d7924 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -8,16 +8,7 @@
 #ifndef _RTW_IO_H_
 #define _RTW_IO_H_
 
-/*
-	For prompt mode accessing, caller shall free io_req
-	Otherwise, io_handler will free io_req
-*/
-
-/* below is for the intf_option bit definition... */
-
-struct intf_priv;
 struct intf_hdl;
-struct io_queue;
 
 struct _io_ops {
 		u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
@@ -36,8 +27,6 @@ struct _io_ops {
 		void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 		void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 
-		void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
-
 		u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
 
 		u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
@@ -49,18 +38,6 @@ struct _io_ops {
 		void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
 };
 
-struct io_req {
-	struct list_head	list;
-	u32 addr;
-	volatile u32 val;
-	u32 command;
-	u32 status;
-	u8 *pbuf;
-
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt);
-	u8 *cnxt;
-};
-
 struct	intf_hdl {
 	struct adapter *padapter;
 	struct dvobj_priv *pintf_dev;/* 	pointer to &(padapter->dvobjpriv); */
@@ -74,21 +51,6 @@ struct	intf_hdl {
 int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj);
 void rtw_reset_continual_io_error(struct dvobj_priv *dvobj);
 
-/*
-Below is the data structure used by _io_handler
-
-*/
-
-struct io_queue {
-	spinlock_t	lock;
-	struct list_head	free_ioreqs;
-	struct list_head		pending;		/* The io_req list that will be served in the single protocol read/write. */
-	struct list_head		processing;
-	u8 *free_ioreqs_buf; /*  4-byte aligned */
-	u8 *pallocated_free_ioreqs_buf;
-	struct	intf_hdl	intf;
-};
-
 struct io_priv {
 
 	struct adapter *padapter;
@@ -97,20 +59,6 @@ struct io_priv {
 
 };
 
-extern uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
-extern void sync_ioreq_enqueue(struct io_req *preq, struct io_queue *ioqueue);
-extern uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
-
-
-extern uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
-extern struct io_req *alloc_ioreq(struct io_queue *pio_q);
-
-extern uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
-extern void unregister_intf_hdl(struct intf_hdl *pintfhdl);
-
-extern void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-extern void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
 extern u8 rtw_read8(struct adapter *adapter, u32 addr);
 extern u16 rtw_read16(struct adapter *adapter, u32 addr);
 extern u32 rtw_read32(struct adapter *adapter, u32 addr);
@@ -121,46 +69,6 @@ extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 
 extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-extern void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
-
-/* ioreq */
-extern void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
-extern void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
-extern void ioreq_read32(struct adapter *adapter, u32 addr, u32 *pval);
-extern void ioreq_write8(struct adapter *adapter, u32 addr, u8 val);
-extern void ioreq_write16(struct adapter *adapter, u32 addr, u16 val);
-extern void ioreq_write32(struct adapter *adapter, u32 addr, u32 val);
-
-
-extern uint async_read8(struct adapter *adapter, u32 addr, u8 *pbuff,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-extern uint async_read16(struct adapter *adapter, u32 addr,  u8 *pbuff,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-extern uint async_read32(struct adapter *adapter, u32 addr,  u8 *pbuff,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-
-extern void async_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-extern void async_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
-extern void async_write8(struct adapter *adapter, u32 addr, u8 val,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-extern void async_write16(struct adapter *adapter, u32 addr, u16 val,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-extern void async_write32(struct adapter *adapter, u32 addr, u32 val,
-	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt), u8 *cnxt);
-
-extern void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-extern void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
-
 int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapter *padapter, struct _io_ops *pops));
 
-
-extern uint alloc_io_queue(struct adapter *adapter);
-extern void free_io_queue(struct adapter *adapter);
-extern void async_bus_io(struct io_queue *pio_q);
-extern void bus_sync_io(struct io_queue *pio_q);
-extern u32 _ioreq2rwmem(struct io_queue *pio_q);
-extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);
-
 #endif	/* _RTL8711_IO_H_ */
diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
deleted file mode 100644
index 5a1cbd2ed851..000000000000
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ /dev/null
@@ -1,341 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTW_MP_H_
-#define _RTW_MP_H_
-
-#define MAX_MP_XMITBUF_SZ	2048
-
-struct mp_xmit_frame {
-	struct list_head	list;
-
-	struct pkt_attrib attrib;
-
-	struct sk_buff *pkt;
-
-	int frame_tag;
-
-	struct adapter *padapter;
-
-	uint mem[(MAX_MP_XMITBUF_SZ >> 2)];
-};
-
-struct mp_wiparam {
-	u32 bcompleted;
-	u32 act_type;
-	u32 io_offset;
-	u32 io_value;
-};
-
-struct mp_tx {
-	u8 stop;
-	u32 count, sended;
-	u8 payload;
-	struct pkt_attrib attrib;
-	/* struct tx_desc desc; */
-	/* u8 resvdtx[7]; */
-	u8 desc[TXDESC_SIZE];
-	u8 *pallocated_buf;
-	u8 *buf;
-	u32 buf_size, write_size;
-	void *PktTxThread;
-};
-
-#define MP_MAX_LINES		1000
-#define MP_MAX_LINES_BYTES	256
-
-typedef void (*MPT_WORK_ITEM_HANDLER)(void *Adapter);
-struct mpt_context {
-	/*  Indicate if we have started Mass Production Test. */
-	bool			bMassProdTest;
-
-	/*  Indicate if the driver is unloading or unloaded. */
-	bool			bMptDrvUnload;
-
-	struct timer_list			MPh2c_timeout_timer;
-/*  Event used to sync H2c for BT control */
-
-	bool		MptH2cRspEvent;
-	bool		MptBtC2hEvent;
-	bool		bMPh2c_timeout;
-
-	/* 8190 PCI does not support NDIS_WORK_ITEM. */
-	/*  Work Item for Mass Production Test. */
-	/* NDIS_WORK_ITEM	MptWorkItem; */
-/* 	RT_WORK_ITEM		MptWorkItem; */
-	/*  Event used to sync the case unloading driver and MptWorkItem is still in progress. */
-/* 	NDIS_EVENT		MptWorkItemEvent; */
-	/*  To protect the following variables. */
-/* 	NDIS_SPIN_LOCK		MptWorkItemSpinLock; */
-	/*  Indicate a MptWorkItem is scheduled and not yet finished. */
-	bool			bMptWorkItemInProgress;
-	/*  An instance which implements function and context of MptWorkItem. */
-	MPT_WORK_ITEM_HANDLER	CurrMptAct;
-
-	/*  1 =Start, 0 =Stop from UI. */
-	u32 		MptTestStart;
-	/*  _TEST_MODE, defined in MPT_Req2.h */
-	u32 		MptTestItem;
-	/*  Variable needed in each implementation of CurrMptAct. */
-	u32 		MptActType;	/*  Type of action performed in CurrMptAct. */
-	/*  The Offset of IO operation is depend of MptActType. */
-	u32 		MptIoOffset;
-	/*  The Value of IO operation is depend of MptActType. */
-	u32 		MptIoValue;
-	/*  The RfPath of IO operation is depend of MptActType. */
-	u32 		MptRfPath;
-
-	enum wireless_mode		MptWirelessModeToSw;	/*  Wireless mode to switch. */
-	u8 	MptChannelToSw;		/*  Channel to switch. */
-	u8 	MptInitGainToSet;	/*  Initial gain to set. */
-	u32 		MptBandWidth;		/*  bandwidth to switch. */
-	u32 		MptRateIndex;		/*  rate index. */
-	/*  Register value kept for Single Carrier Tx test. */
-	u8 	btMpCckTxPower;
-	/*  Register value kept for Single Carrier Tx test. */
-	u8 	btMpOfdmTxPower;
-	/*  For MP Tx Power index */
-	u8 	TxPwrLevel[2];	/*  rf-A, rf-B */
-	u32 		RegTxPwrLimit;
-	/*  Content of RCR Register for Mass Production Test. */
-	u32 		MptRCR;
-	/*  true if we only receive packets with specific pattern. */
-	bool			bMptFilterPattern;
-	/*  Rx OK count, statistics used in Mass Production Test. */
-	u32 		MptRxOkCnt;
-	/*  Rx CRC32 error count, statistics used in Mass Production Test. */
-	u32 		MptRxCrcErrCnt;
-
-	bool			bCckContTx;	/*  true if we are in CCK Continuous Tx test. */
-	bool			bOfdmContTx;	/*  true if we are in OFDM Continuous Tx test. */
-	bool			bStartContTx;	/*  true if we have start Continuous Tx test. */
-	/*  true if we are in Single Carrier Tx test. */
-	bool			bSingleCarrier;
-	/*  true if we are in Carrier Suppression Tx Test. */
-	bool			bCarrierSuppression;
-	/* true if we are in Single Tone Tx test. */
-	bool			bSingleTone;
-
-	/*  ACK counter asked by K.Y.. */
-	bool			bMptEnableAckCounter;
-	u32 		MptAckCounter;
-
-	/*  SD3 Willis For 8192S to save 1T/2T RF table for ACUT	Only fro ACUT delete later ~~~! */
-	/* s8		BufOfLines[2][MAX_LINES_HWCONFIG_TXT][MAX_BYTES_LINE_HWCONFIG_TXT]; */
-	/* s8			BufOfLines[2][MP_MAX_LINES][MP_MAX_LINES_BYTES]; */
-	/* s32			RfReadLine[2]; */
-
-	u8 APK_bound[2];	/* for APK	path A/path B */
-	bool		bMptIndexEven;
-
-	u8 backup0xc50;
-	u8 backup0xc58;
-	u8 backup0xc30;
-	u8 backup0x52_RF_A;
-	u8 backup0x52_RF_B;
-
-	u32 		backup0x58_RF_A;
-	u32 		backup0x58_RF_B;
-
-	u8 	h2cReqNum;
-	u8 	c2hBuf[32];
-
-    u8          btInBuf[100];
-	u32 		mptOutLen;
-    u8          mptOutBuf[100];
-
-};
-/* endif */
-
-/* define RTPRIV_IOCTL_MP					(SIOCIWFIRSTPRIV + 0x17) */
-enum {
-	WRITE_REG = 1,
-	READ_REG,
-	WRITE_RF,
-	READ_RF,
-	MP_START,
-	MP_STOP,
-	MP_RATE,
-	MP_CHANNEL,
-	MP_BANDWIDTH,
-	MP_TXPOWER,
-	MP_ANT_TX,
-	MP_ANT_RX,
-	MP_CTX,
-	MP_QUERY,
-	MP_ARX,
-	MP_PSD,
-	MP_PWRTRK,
-	MP_THER,
-	MP_IOCTL,
-	EFUSE_GET,
-	EFUSE_SET,
-	MP_RESET_STATS,
-	MP_DUMP,
-	MP_PHYPARA,
-	MP_SetRFPathSwh,
-	MP_QueryDrvStats,
-	MP_SetBT,
-	CTA_TEST,
-	MP_DISABLE_BT_COEXIST,
-	MP_PwrCtlDM,
-	MP_NULL,
-	MP_GET_TXPOWER_INX,
-};
-
-struct mp_priv {
-	struct adapter *papdater;
-
-	/* Testing Flag */
-	u32 mode;/* 0 for normal type packet, 1 for loopback packet (16bytes TXCMD) */
-
-	u32 prev_fw_state;
-
-	/* OID cmd handler */
-	struct mp_wiparam workparam;
-/* 	u8 act_in_progress; */
-
-	/* Tx Section */
-	u8 TID;
-	u32 tx_pktcount;
-	u32 pktInterval;
-	struct mp_tx tx;
-
-	/* Rx Section */
-	u32 rx_bssidpktcount;
-	u32 rx_pktcount;
-	u32 rx_pktcount_filter_out;
-	u32 rx_crcerrpktcount;
-	u32 rx_pktloss;
-	bool  rx_bindicatePkt;
-	struct recv_stat rxstat;
-
-	/* RF/BB relative */
-	u8 channel;
-	u8 bandwidth;
-	u8 prime_channel_offset;
-	u8 txpoweridx;
-	u8 txpoweridx_b;
-	u8 rateidx;
-	u32 preamble;
-/* 	u8 modem; */
-	u32 CrystalCap;
-/* 	u32 curr_crystalcap; */
-
-	u16 antenna_tx;
-	u16 antenna_rx;
-/* 	u8 curr_rfpath; */
-
-	u8 check_mp_pkt;
-
-	u8 bSetTxPower;
-/* 	uint ForcedDataRate; */
-	u8 mp_dm;
-	u8 mac_filter[ETH_ALEN];
-	u8 bmac_filter;
-
-	struct wlan_network mp_network;
-	NDIS_802_11_MAC_ADDRESS network_macaddr;
-
-	u8 *pallocated_mp_xmitframe_buf;
-	u8 *pmp_xmtframe_buf;
-	struct __queue free_mp_xmitqueue;
-	u32 free_mp_xmitframe_cnt;
-	bool bSetRxBssid;
-	bool bTxBufCkFail;
-
-	struct mpt_context MptCtx;
-
-	u8 *TXradomBuffer;
-};
-
-/* Hardware Registers */
-extern u8 mpdatarate[NumRates];
-
-#define MAX_TX_PWR_INDEX_N_MODE 64	/*  0x3F */
-
-#define		REG_RF_BB_GAIN_OFFSET	0x7f
-#define		RF_GAIN_OFFSET_MASK	0xfffff
-
-/*  */
-/* struct mp_xmit_frame *alloc_mp_xmitframe(struct mp_priv *pmp_priv); */
-/* int free_mp_xmitframe(struct xmit_priv *pxmitpriv, struct mp_xmit_frame *pmp_xmitframe); */
-
-s32 init_mp_priv(struct adapter *padapter);
-void free_mp_priv(struct mp_priv *pmp_priv);
-s32 MPT_InitializeAdapter(struct adapter *padapter, u8 Channel);
-void MPT_DeInitAdapter(struct adapter *padapter);
-s32 mp_start_test(struct adapter *padapter);
-void mp_stop_test(struct adapter *padapter);
-
-u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
-void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
-
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
-void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
-
-void SetChannel(struct adapter *padapter);
-void SetBandwidth(struct adapter *padapter);
-int SetTxPower(struct adapter *padapter);
-void SetAntennaPathPower(struct adapter *padapter);
-void SetDataRate(struct adapter *padapter);
-
-void SetAntenna(struct adapter *padapter);
-
-s32 SetThermalMeter(struct adapter *padapter, u8 target_ther);
-void GetThermalMeter(struct adapter *padapter, u8 *value);
-
-void SetContinuousTx(struct adapter *padapter, u8 bStart);
-void SetSingleCarrierTx(struct adapter *padapter, u8 bStart);
-void SetSingleToneTx(struct adapter *padapter, u8 bStart);
-void SetCarrierSuppressionTx(struct adapter *padapter, u8 bStart);
-void PhySetTxPowerLevel(struct adapter *padapter);
-
-void fill_txdesc_for_mp(struct adapter *padapter, u8 *ptxdesc);
-void SetPacketTx(struct adapter *padapter);
-void SetPacketRx(struct adapter *padapter, u8 bStartRx);
-
-void ResetPhyRxPktCount(struct adapter *padapter);
-u32 GetPhyRxPktReceived(struct adapter *padapter);
-u32 GetPhyRxPktCRC32Error(struct adapter *padapter);
-
-s32	SetPowerTracking(struct adapter *padapter, u8 enable);
-void GetPowerTracking(struct adapter *padapter, u8 *enable);
-
-u32 mp_query_psd(struct adapter *padapter, u8 *data);
-
-void Hal_SetAntenna(struct adapter *padapter);
-void Hal_SetBandwidth(struct adapter *padapter);
-
-void Hal_SetTxPower(struct adapter *padapter);
-void Hal_SetCarrierSuppressionTx(struct adapter *padapter, u8 bStart);
-void Hal_SetSingleToneTx(struct adapter *padapter, u8 bStart);
-void Hal_SetSingleCarrierTx(struct adapter *padapter, u8 bStart);
-void Hal_SetContinuousTx(struct adapter *padapter, u8 bStart);
-
-void Hal_SetDataRate(struct adapter *padapter);
-void Hal_SetChannel(struct adapter *padapter);
-void Hal_SetAntennaPathPower(struct adapter *padapter);
-s32 Hal_SetThermalMeter(struct adapter *padapter, u8 target_ther);
-s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable);
-void Hal_GetPowerTracking(struct adapter *padapter, u8 *enable);
-void Hal_GetThermalMeter(struct adapter *padapter, u8 *value);
-void Hal_mpt_SwitchRfSetting(struct adapter *padapter);
-void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14);
-void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *padapter, bool beven);
-void Hal_SetCCKTxPower(struct adapter *padapter, u8 *TxPower);
-void Hal_SetOFDMTxPower(struct adapter *padapter, u8 *TxPower);
-void Hal_TriggerRFThermalMeter(struct adapter *padapter);
-u8 Hal_ReadRFThermalMeter(struct adapter *padapter);
-void Hal_SetCCKContinuousTx(struct adapter *padapter, u8 bStart);
-void Hal_SetOFDMContinuousTx(struct adapter *padapter, u8 bStart);
-void Hal_ProSetCrystalCap(struct adapter *padapter, u32 CrystalCapVal);
-void MP_PHY_SetRFPathSwitch(struct adapter *padapter, bool bMain);
-u32 mpt_ProQueryCalTxPower(struct adapter *padapter, u8 RfPath);
-void MPT_PwrCtlDM(struct adapter *padapter, u32 bstart);
-u8 MptToMgntRate(u32 MptRateIdx);
-
-#endif /* _RTW_MP_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 738a601c55bb..de48c3454ab3 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -724,8 +724,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_free_mlme_priv(&padapter->mlmepriv);
 
-	/* free_io_queue(padapter); */
-
 	_rtw_free_xmit_priv(&padapter->xmitpriv);
 
 	_rtw_free_sta_priv(&padapter->stapriv); /* will free bcmc_stainfo here */
-- 
2.43.0


