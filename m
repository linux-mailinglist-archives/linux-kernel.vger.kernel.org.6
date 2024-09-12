Return-Path: <linux-kernel+bounces-326896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C04976E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3503B23DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA71BA292;
	Thu, 12 Sep 2024 15:53:45 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE00199948
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156425; cv=none; b=oOaFN/r6Cy6NrdCfr7bNgIKgscY83dAuGEmdxU8k4aaZQqWZ/FWvrHtR1dOLUXurehrpeB9zjJ+32BKZPgRkWbEYuEQhW+LbYjXNGSTrtwNwdSq2MzMUqfRbo2mEL9UrLJt7xS0CxgEyos1yAbIES5gxD1685G5tq9Cbl6Yja2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156425; c=relaxed/simple;
	bh=H3Fhj71qw/sn6U0lOBAG0Po7bRVCrYtJ9cdxwhKoiIo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ9tYOyZd/yFGiMUPelsNKrEQjOH65UhouAEPMoIqunbyZXbiRkxWTs6Ggav8ni950kdfPUvx++NcsaLCTbKcyWDJ3hgrjA4Xx788xHvF4/XmEEkl5MrVivOUIyXIz8Ya/aWuFWPOEbToth7/qrTEpQB7ol3MBJex6RfZ++xBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 293b1902-711f-11ef-9150-005056bdfda7;
	Thu, 12 Sep 2024 18:53:33 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Sep 2024 18:53:32 +0300
To: Pawel Laszczak <pawell@cadence.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Message-ID: <ZuMOfHp9j_6_3-WC@surfacebook.localdomain>
References: <20240905065716.305332-1-pawell@cadence.com>
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>

Thu, Sep 05, 2024 at 07:06:48AM +0000, Pawel Laszczak kirjoitti:
> Please ignore this patch. I send it again with correct version in subject.

It seems it's in Mathias' tree, never the less, see also below.

...

> >+#define PCI_DEVICE_ID_CADENCE				0x17CD

First of all this is misleadig as this is VENDOR_ID, second, there is official
ID constant for Cadence in pci_ids.h.

#define PCI_VENDOR_ID_CDNS              0x17cd

-- 
With Best Regards,
Andy Shevchenko



