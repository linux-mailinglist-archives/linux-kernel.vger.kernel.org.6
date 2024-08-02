Return-Path: <linux-kernel+bounces-273162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79767946512
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FBA28309B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681261FFC;
	Fri,  2 Aug 2024 21:31:33 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC61396
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634293; cv=none; b=p4kJ97LI8JonYKovjkYogZ+y6BqPoy8vzqd6Hx6QKF312naHdPylL0YJej/eR+tdTL/A7fa4FN5yDgwZ7/tBvArR+w/nQEprsAG4Cg6UOtrZDw+2eh5OesuKqp/4fuFlw3AYR3UkgkvXLAi1pnOcSVCifNAUzdyzIIL8hYqctlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634293; c=relaxed/simple;
	bh=N/bkhoclcDF9N6YGdC5UP2Cv+bxlhp/62VCe8P1bU90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpwyCFRva3JdeRASsrf+VxXgRWWi9sD8oBHcMjDqKHaYI+fZSvUV+35OvTM2s2zKpFwRFKbsftdpbgep+dPw2Hxjwurn8srJ+w+Gs7WPOTJ+/R9onn1Wwq3ZfIS+hqitXT+uI9hLBZs5ZRS94PTiheV0IJma+0SfIz4H2pZMlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso6414183b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634291; x=1723239091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbmO4KOuDaOFuESIt0suPWSi7GBxZGUwlTBYZeh0caY=;
        b=FivfkXhqsHJdFcoA1UP9rB2++ZVblBpiSAJLbSUVlLRF70mYH18ugdFE5rmbNzv7FO
         mAZZJwkbi/3Mzc7wElxfJJgplHxykIAEMRxLPSxLS1iXVqbG0V1eo2YvMcH03P0ocMJ8
         jtNtfSDCb3s5dYo0w7gqOQ53GV47eiBqWjr5vthxhU9enaFC4AdW0IJVLjF/C28ltKXv
         WmmsNRKvCSbA2MXGhloCJ8NDLec+wrx0iuOV6kSB7l0OVsSPctzdVj+Y26KrP130M/tm
         AFq/tXUIL0wEY0HEhaiQXEefr+WnLRsl1BUQEmdc0JtKQtiXlZi2jwW2/clgrih2YVU2
         TdeA==
X-Gm-Message-State: AOJu0YzBs8GicBzKAOoMDn2DHc2k7uBwqRfnpmRkeq50aQIbZ3bM2iNF
	xCqU5RhSvUQNLKwr4pVB7R2vi9ILevqde03r8yw2L/OBnPAckCFWckzaKQ==
X-Google-Smtp-Source: AGHT+IH3UbGQleUVjw9w0t5wUQiA/gOoVLvw7jq+Jgh7DMqK3q9VYMiZDZhoLDsPOSwNiUkJIbtuPA==
X-Received: by 2002:a05:6a00:1790:b0:70d:2ac8:c838 with SMTP id d2e1a72fcca58-7106cf8ac9emr6514373b3a.4.1722634291104;
        Fri, 02 Aug 2024 14:31:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdff89sm1754808b3a.103.2024.08.02.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:31:30 -0700 (PDT)
Date: Fri, 2 Aug 2024 21:31:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kys <kys@microsoft.com>,
	haiyangz <haiyangz@microsoft.com>, "wei.liu" <wei.liu@kernel.org>,
	decui <decui@microsoft.com>
Subject: Re: BUG: stack guard page was hit in vsock_connectible_recvmsg
Message-ID: <Zq1QMacH8BCA_UW5@liuwe-devbox-debian-v2>
References: <59b20304-a273-4882-8dfb-fe9a668ec8d8.bugreport@valiantsec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b20304-a273-4882-8dfb-fe9a668ec8d8.bugreport@valiantsec.com>

Hello

On Mon, Jul 29, 2024 at 10:22:37AM +0800, Ubisectech Sirius wrote:
> 
>  vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> 

I'm not sure why I (or other Hyper-V folks) were CC'ed on
this email.

Per get_maintainer.pl, the maintainers of the vmw_vsock directory are:

Stefano Garzarella <sgarzare@redhat.com> (maintainer:VM SOCKETS (AF_VSOCK))
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK))
linux-kernel@vger.kernel.org (open list)

You probably want to resend your report to them.

Thanks,
Wei.

