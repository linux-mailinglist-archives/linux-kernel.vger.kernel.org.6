Return-Path: <linux-kernel+bounces-240013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15469267E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634781F25524
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E4186E34;
	Wed,  3 Jul 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiNo3FoG"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22C185E53
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030384; cv=none; b=KAhLUBI0osWCwWHZRmLdbFD6FK5RUupDc5tdicptT7wB4k+i3fYpC2TWbYUF7QDBTiUYbs1PjByYDvXQVg5Ho4lkRWXa7RPpZFcT4H/uxLakxgc2Os56uDtuLEf/A9aYgVUCED+SparjEP2Mc3r0ypA1zxKBbZ7UngOZTVaatfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030384; c=relaxed/simple;
	bh=qIa2fXZ/LABjkrCC653iYMwobCB1tn07viAK0DYlZ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcOaLdo+q04LNq5BE/xenX/ha12qIyWIDHq+lNtkJeoWyxH8lneQ77BfkL7MyFectKs5W51OBdQIqb49pUh44whawyEB9Gdo+eOwKriTxopDT9/64nQy/9rK8dGLe+l3VdXPIMzPky3opwof6MXed0XWzWZlgGw3PR+uQnsBftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiNo3FoG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so3491203a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720030382; x=1720635182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C22RcSIRkfE0B40oVSf3G92rCdB5zbkxst2mtF29dFY=;
        b=SiNo3FoGz439AJOl8+RgOi07O4YVOLEEhYIyMitxaniowqX10ZCff6AyVkJaBqMwV2
         BsYpYWT0FUXfGxLUlUcQf00JdWTnNQlNR67ktNfq/uYgSOb1INpqc4SiFg31mUd09cpH
         G1ZDYMV4XfGAzlNn1jtLX3yzs+HdxiZZhJGJoH+dbogZUReeQEgljSTtAOYyToNh8Ncq
         dTx8o0ovb7pjpGLxqvUPhB9Mdja81jAhmCjzPzW8w23CMoKU/b8SkBGnU59O0vCjBrXb
         PM80jWlxqTq7JXi6IUQu3g5a7lwqDg/KzPH188V9eSU2cdwBnWxbvEHUJ4vvYENMxyPd
         /JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030382; x=1720635182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C22RcSIRkfE0B40oVSf3G92rCdB5zbkxst2mtF29dFY=;
        b=eieqclNFy/MO5vPPJX/NcX+mTxpbi0ujzIzUT4qhrW6y6IwpVKj7M3GPjvuG6n4pNn
         /5tvTz6hWs9NZYRA17ED+PzNkWeTJJF9MMiNf0ot8SOy6wncZGmuEaE3yEoEA0HOAzy1
         wVLvOg9ngGoWJFiyi0AKQmc/EkFyLbk3kSlTtb8li3Mnb9g+0YuiUnq7xyzDiTJSCy+x
         k6FSBdiYDdnSlqbKt6PIi46gFEoeJukJVXG7x/Otqb5eXUYitoZKxUy8OsGAVcXqvZ0M
         VbIO/zQwo+ZJWWhLNf0079pU3In66AygFQeaXaANlMezCQuR/lZ5d/L6kH1xeGb8rGOY
         avnA==
X-Gm-Message-State: AOJu0YxCv7jZJknvQa2W/1uE+ref78NKCSQHF/bSAT7pfCeylULXsOHD
	fystYz6opHB7XgZXKLxLvLGez4v/JYjteKlGHXF3TY/RaYVbfp4scyIoMw==
X-Google-Smtp-Source: AGHT+IEP9xkSB0RE8884dgBuT6toHz48Y7XrEJ32zE/3Ke6zZjvCX0TP1ubDVO1vE5KzvjyeBsb4wg==
X-Received: by 2002:a05:6a20:258f:b0:1bd:18ee:f141 with SMTP id adf61e73a8af0-1bef611b9b9mr12568222637.4.1720030382403;
        Wed, 03 Jul 2024 11:13:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3935sm108803455ad.77.2024.07.03.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:13:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:13:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Move uclamp to each sched_class
Message-ID: <ZoWUrdj4ZT61KY4l@slm.duckdns.org>
References: <cover.1719999165.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719999165.git.hongyan.xia2@arm.com>

Hello,

On Wed, Jul 03, 2024 at 11:07:46AM +0100, Hongyan Xia wrote:
> Hi. I only just started looking at sched_ext a couple of days ago so
> feel free to correct me if sched_ext patches have different rules,
> different cc's and different mailing lists than normal LKML.

The first patch should go through the usual scheduler tree, so please cc the
scheduler maintainers and probably the original uclamp author too. Once that
lands, I can pull in and apply the second sched_ext specific patch.

Thanks.

-- 
tejun

