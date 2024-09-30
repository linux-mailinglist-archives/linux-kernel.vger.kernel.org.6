Return-Path: <linux-kernel+bounces-344706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0398AD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DB3B237CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6F199E8B;
	Mon, 30 Sep 2024 19:40:13 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5C15E97;
	Mon, 30 Sep 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725212; cv=none; b=EsaHO8zl3f9bMPb2CNdKdeDvNFxqenrHDqQlqyyYjhSQ4Py8N2SuGYwZRy5LaMI9kxgOEecwVpf+HfSxCvaAQT5TrtZBSUTPzEF62+3oK0DocioiWV7wCEfdQ7fHedf6GqaN+ZAFWq1VJKD9qqG/D5pY7dIEbu5muoQQ8hqUvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725212; c=relaxed/simple;
	bh=e39O9i8KNuQKU6yo245+NtHRI5zD3SznBknI0fyUa7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuL8PJzGvfsJQxlfA5PXXJPE0bcEIRPe25WquvfAMIplLEdrB/eXp+avRvFJSrI4hlzGypV7r2WqowmfD8ROyf1/CzJNJauOvJ+MvfAx6dzdYD10z/KSnYBJdhq79g0/+RZ6+urEKVL5/J70wm1EjQw80fqKxA2TJiVxXUZ4Kgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1svMFR-0000000050w-0VwY;
	Mon, 30 Sep 2024 19:39:57 +0000
Date: Mon, 30 Sep 2024 20:39:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>
Cc: chengzhihao1 <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, robh <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mtd: ubi: add support for protecting critical
 volumes
Message-ID: <Zvr-hOM2DfveaqeC@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org>
 <251386789.117942.1727612762462.JavaMail.zimbra@nod.at>
 <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com>
 <364911897.123906.1727721820227.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <364911897.123906.1727721820227.JavaMail.zimbra@nod.at>

On Mon, Sep 30, 2024 at 08:43:40PM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "chengzhihao1" <chengzhihao1@huawei.com>
> >>> Von: "Daniel Golle" <daniel@makrotopia.org>
> >>> Allow the boot firmware to define volumes which are critical for the
> >>> system to boot, such as the bootloader itself if stored inside a UBI
> >>> volume. Protect critical volumes by preventing the user from removing,
> >>> resizing or writing to them, and also prevent the UBI device from
> >>> being detached if a critical volume is present.
> >> 
> >> I agree with the doubts raised in patch 1/2, if userspace is so hostile
> >> to delete system partitions, there is little hope.
> >> But I'm still open for discussion.
> > 
> > Yes, I agree that it is meaningful to prevent user from operating
> > volumes accidently. How about doing that by some existing methods? Eg.
> > selinux(Design sepolicy for ioctl cmd).
> 
> Another thought, do we really need to enforce this in kernel space?
> Teaching ubi-tools to be super careful with some volumes is also an option.
> 
> like a ubirmvol ... --i-know-what-im-doing.

True, enforcement doesn't need to happen in kernel (though I think it's
nicer, but really just a matter of taste, I guess). ubi-tools would still
need to be able to recognize critical volumes somehow, and that could be
done by checking if the 'volume-is-critical' property is present in
/sys/class/ubi/ubi*_*/of_node/

If you prefer going down that road instead I will work on patches for
git.infradead.org/mtd-utils.git instead.

