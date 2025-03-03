Return-Path: <linux-kernel+bounces-544512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64579A4E23D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D6C3A314F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980727C149;
	Tue,  4 Mar 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWWw2ljQ"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0C20A5EB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099841; cv=fail; b=bCjqgxiWCo0u+kxG7kEmqsx6TK6FJzpsSVnb5wgYwdd0T88QgNEbkgmDozg3TaOSTAJFlu9vUH/hypRSgMYmMgSa3Ff3QeVOhEwqM12ox5OjzN+s+BBShzIpE3bGG/SP36aAXy7W4GyO209u93Hr4XM1KQIhpJElLbuIxEtqIPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099841; c=relaxed/simple;
	bh=KnNHqHujTr4Q0GxlaELiFS7wRZS3JhquBuOBmHcIfCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjjCFksgPOjyEITpDPxLs3oWKwHO4/O7rAco/qQqdDTdWzUg0kzRLQPDHl3ASZwoppFSgdmYvbk88TZHAZADMFSFEwWr2yhkz7PY/4Kvn2akTAI6UmbbT9fXa4G40UfgElqNTRWJHxFO0sbdy3JvsmKusEFBtDWGNGjidWkxm08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWw2ljQ reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.16; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 34D3140CF12A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:50:38 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dJt4d47zFwKl
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:26:06 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C3FC442729; Tue,  4 Mar 2025 17:25:56 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWw2ljQ
X-Envelope-From: <linux-kernel+bounces-541153-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWw2ljQ
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1111B4277E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:30:37 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id A319B2DCFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:30:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4123A9169
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28DF1EFF81;
	Mon,  3 Mar 2025 08:27:22 +0000 (UTC)
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
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dJt4d47zFwKl
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704531.14301@OlzzfeGOe4V5b85FaEANaw
X-ITU-MailScanner-SpamCheck: not spam

On 1.3.2025 4.05, Kuangyi Chiang wrote:
> Hi,
>=20
> Thanks for the patch.
>=20
> Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B43=E6=
=9C=881=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:17=E5=AF=AB=E9=81=
=93=EF=BC=9A

>> index 8c164340a2c3..c75c2c12ce53 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1371,7 +1371,7 @@ struct xhci_ring {
>>          unsigned int            num_trbs_free; /* used only by xhci D=
bC */
>>          unsigned int            bounce_buf_len;
>>          enum xhci_ring_type     type;
>> -       bool                    last_td_was_short;
>> +       u32                     last_td_comp_code;
>=20
> Should be changed to old_trb_comp_code.
>=20

Thanks, forgot to add that last xhci.h change to the patch

-Mathias



