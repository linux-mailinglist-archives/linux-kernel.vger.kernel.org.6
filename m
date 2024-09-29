Return-Path: <linux-kernel+bounces-343069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474F98966D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F241F211D8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642E17E013;
	Sun, 29 Sep 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EBo2Yob6"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1B17C230
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629515; cv=none; b=hKMkBGej8VWdwaM97ZWvjZ+NEpEpEfTzptVDbMbYKE0CCqZ/fPUpz4qKq4JV+TRI37Pb7INMt/087RtzX9YR1u68AjW41KEG+MNpGBYjfko73XGtfrCk97NVyp2QoKTjD7NCdil5j47m3RT+uv8evyoasMPmkDr/blP45DBVOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629515; c=relaxed/simple;
	bh=U0wzIqDyqvUGlypPk4gYq425Ue/tIO2qK0tgxoZSBGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PYpePeUxaLNU2TWT/sD43hwTFPKMOmg4r/QsDHVG/2kfDhxMMre3GUMLepnXNmABLrIh0iMrFs+lLgfX8wTJ4qPo/CKxPYEvgLx3RjCgF/Oyk3KyB7qqyVpMUJakR8/tb6saovqNKQD5SVmZUWb9l++trTd+3AfP9vs40sD3hfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EBo2Yob6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=zJoVyOezk87flQP/T1rSos3kBIbqevdYSEXyE/WYDJI=; b=EBo2Yob6sbucRYfk
	BLsjh54oBHEjhrLQtNgvOvjz/amc+KQrHrEbUx5bskLdfZ3lBzdBa3S0F4OYQChomNI7uk3VZbUvm
	FVASiw9lpM207UxUx62KpMEjly+Dg6QO8xzv/7J+dYQEFtnwFNpVpvVMDyaLhiGC/sSCtSmmbBoH1
	K/Zw/KUkJFPzLudaAxRJ/VgQOz8aEy/f9O64+dbvFqiOjofOFLW8y51tv25sqCVK1o9Y+SYx9oQmd
	6YlzgPEyKr0o+n2SHI+qt9ThIzl9ab/JJuOzeR/+aO6/CDYVFJkCikQskWyI3XuhhB1/Lng5cXaim
	wIrmTZfabkYwhgrClw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1suxLx-007pnh-38;
	Sun, 29 Sep 2024 17:05:01 +0000
Date: Sun, 29 Sep 2024 17:05:01 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: boris.brezillon@collabora.com
Cc: nicolas.ferre@microchip.com, miquel.raynal@bootlin.com, richard@nod.at,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: of atmel_pmecc_destroy_user
Message-ID: <ZvmIvRJCf6VhHvpo@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:56:56 up 144 days,  4:10,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Boris and co,
  One of my scripts noticed that 'atmel_pmecc_destroy_user'
isn't called anywhere; I was going to delete it, but hmm, I wonder
if it's actually a missing call and leaking (in the unlikely case
the device was ever removed).

It was added by your:
  commit f88fc122cc34c2545dec9562eaab121494e401ef
  Author: Boris Brezillon <bbrezillon@kernel.org>
  Date:   Thu Mar 16 09:02:40 2017 +0100

    mtd: nand: Cleanup/rework the atmel_nand driver

and I see the allocation in:
     user = kzalloc(size, GFP_KERNEL);
       in
     nand->pmecc = atmel_pmecc_create_user(nc->pmecc, &req);
       called in atmel_nand_pmecc_init
         from atmel_nand_ecc_init
           from atmel_hsmc_nand_ecc_init
 
But I don't see any freeing.

(I don't knowingly have hardware to test a fix, although I guess
there's probably one somewhere....)

Suggestions?

Thanks,

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

