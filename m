Return-Path: <linux-kernel+bounces-541153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD79A4B939
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9768E7A1C29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931E1EF096;
	Mon,  3 Mar 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWWw2ljQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C81EB192;
	Mon,  3 Mar 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990440; cv=none; b=ksjeSJFTqZFNgHIaGiH+2nqTk+Tk2d9Zivw6fbCa6/HVmUxXQo5jhc/PKBhqcxoDhVOD+ejP0Knz9FAb0v0xA5sVwnRmy9K899/NNfccKrH0ZkN26bGYvyCAiwBthdlFR3N1AdkJxlJoVNg5i1q12WEYNNtr1XjRO2wBIHgckMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990440; c=relaxed/simple;
	bh=gfkLZLX0yooK4MMPMKN+Ae9vAFIEBayZf/3aAJEh/Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkbUYwmE7YKMBfTgFELPfXQUQ2myLiCQbZhXPTs+HVihnpeUMTbXzsLhEhWWeXo4MnxHExbLfbJ0FU4dLRu6RaOtlWbLAA0S0CHqDB+Z/f7m+R+z+hPYq/vRj52dIuhExDHXpsj2TyzDh9SiLxA1ObKqOJSvOCG8YpH5vxCObL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWw2ljQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740990438; x=1772526438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gfkLZLX0yooK4MMPMKN+Ae9vAFIEBayZf/3aAJEh/Xc=;
  b=AWWw2ljQGSHaLKiuV4dEamox3kXMKYex7ULDn4B89hyn5brtnkXtpUSE
   yQaFDhmPV4RRmpPCxiCnsd5+KnqFdWIphi4E1rBscaelDk7+Y/hh6HQP+
   5fghrQoDY4JabduN1aA+C3cMKDPDAw3Kvrt0qmSg2Vidu7StUbdzldCGE
   WwuxZNAHYvu6OrDeVGciY3jhWuzqoaL9XwZBU8WKNlMr1NUvXr22EgooH
   tL3aqWcsVQH6gQR+Ip9cL9zKQEnkoh0coKh2AFd8o7Syfm4CsOg3pHv11
   jthDL8gvx50vZYb+kRj3s6vy3lVXYDBsBA8++9PA+GLOj+5Pi7gymab2N
   Q==;
X-CSE-ConnectionGUID: sRSWvC2kSWu6vvn2cdgZgA==
X-CSE-MsgGUID: LTN6fn5lSiSIJSX2/h6rdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="29442383"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="29442383"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:27:17 -0800
X-CSE-ConnectionGUID: VbCv2Ah+RvqqRPOSiOzT+A==
X-CSE-MsgGUID: 8hCEqOGWQzW9ywrFdbgxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117963136"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2025 00:27:16 -0800
Message-ID: <53a7a698-410f-47b2-b50b-9368e4f02cf9@linux.intel.com>
Date: Mon, 3 Mar 2025 10:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: michal.pecio@gmail.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
 <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
 <CAHN5xi0mf8G4ODMQ9jDXAM4CRXtafZeMh_2KF7efbiFJahO4bw@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CAHN5xi0mf8G4ODMQ9jDXAM4CRXtafZeMh_2KF7efbiFJahO4bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1.3.2025 4.05, Kuangyi Chiang wrote:
> Hi,
> 
> Thanks for the patch.
> 
> Mathias Nyman <mathias.nyman@linux.intel.com> 於 2025年3月1日 週六 上午12:17寫道：

>> index 8c164340a2c3..c75c2c12ce53 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1371,7 +1371,7 @@ struct xhci_ring {
>>          unsigned int            num_trbs_free; /* used only by xhci DbC */
>>          unsigned int            bounce_buf_len;
>>          enum xhci_ring_type     type;
>> -       bool                    last_td_was_short;
>> +       u32                     last_td_comp_code;
> 
> Should be changed to old_trb_comp_code.
> 

Thanks, forgot to add that last xhci.h change to the patch

-Mathias


