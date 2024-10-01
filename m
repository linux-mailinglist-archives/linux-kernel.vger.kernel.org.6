Return-Path: <linux-kernel+bounces-346474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A482C98C517
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB8F1F241A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1541CCB45;
	Tue,  1 Oct 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KU6+UDb0"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C21CCB3A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806046; cv=none; b=Y6y47DMlB/UyJ6FFoPQTHNLF28fXT2t94Z/lRSz3u7KVVGf0ayKLeuuSgphsYF4S0zRGCBJeqICLJ53dZd8jzopV1YgTKJhajbNRIuBb5PZkr78tG+lRY/aLx9QN+UA+lJsIG/TOFV/mxrHCb7n9tPVZbDbG/RwCftLFEFjCiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806046; c=relaxed/simple;
	bh=lKv1oPd1u6ZafX752GT6OJMf43JnT/5BtZuMMtd4hGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P681KEDuyJdYPZzmSoaFc9AB1cJnkqnoLA2yjJ3zAiinwTBztn3JDxoqNXj4TE+chtmpo9DD5ELpaa8ahUnzcnUPVJxhOErDayrNSW2HNBMCAaSBK/X0bg4JT2m2beAi0s2AOtP+08Qhzr+vCvBrkA5HGd4H9OlzHltNAoH2B7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KU6+UDb0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3914879a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727806044; x=1728410844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlfIDLL8X+h1iXFwaqyKKzJo5oDK37QI3Hy/+CpBMIs=;
        b=KU6+UDb0TiUTtvTfVjNGiyYeXwPmSSOklNtUgnpjM5eCU+fT3BtGqVdSIyruahg7s0
         fS/Jtm0G9S/Z92LOwmap7GiSXE2O4ztwL2P+RsnQDZv7HI+jFXtlAbgAWYdToE9UUNlG
         AmUYWOBw2IRF73OiPDMHxGq2denCd7mayOkSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727806044; x=1728410844;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlfIDLL8X+h1iXFwaqyKKzJo5oDK37QI3Hy/+CpBMIs=;
        b=I0AgB8BzvzQtqT8ljiT/5VjEd1eENY6u5y9LFmmsZpnVx2FDqKgyekuXw0fxgybIVA
         SRCam4GoPNf5WuaOap5u99t/SP7b5R24ST4WFNXoF+pghidK5VR8yzuQBnfAQveCf+aK
         aGm6PV0GZHxi0NqaVkRDuJxQ3uSfktFmGxkBfgi98NBYx8pQSxb2OYkaZ+r+FZdmefPu
         YcjftsZAWIW9biT8eWyqYOX9qOIi/63Rwl30Tak9yU7lU57r0ye8sZO708SKFmubJOLb
         up3rIaqqfd2LmXDAAG+am2BzSwzbSRMbXJHc5h/ujha4KgX7VgXNxvUU95/iiFh6lXLY
         Fl6w==
X-Forwarded-Encrypted: i=1; AJvYcCXbQ4nX6etLFbU8eVPXuUNI5+J5Ntffakz2INyDB2+09YYEIkDcE6vaq9aMbDxJ25NTvwewqMvkKVrd5ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUQVcnD25OYNewE4p1VFoYOdwqK/g2Zl22IQpiF5dKiCFXnNC
	RcDU3z16KjmkvXY+74HoDz6BUjwtK/6Sv7UNvp7905DXnTxWlU2522+ULWRhtuI=
X-Google-Smtp-Source: AGHT+IGzb38o63/1Jf14hRPcELRzrT96vMV7+jxQmAG1DD4+K4rabFqw4JMpN8Rh//7ySnQXE6tHUw==
X-Received: by 2002:a05:6a20:d503:b0:1cf:2aaa:9199 with SMTP id adf61e73a8af0-1d5db22de58mr822622637.15.1727806044197;
        Tue, 01 Oct 2024 11:07:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536645sm8343990b3a.188.2024.10.01.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:07:23 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:07:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <Zvw6WIbaRKzNMVF_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <d631f97559534c058fbd5c95afcb807a@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d631f97559534c058fbd5c95afcb807a@amazon.com>

On Tue, Oct 01, 2024 at 04:40:32PM +0000, Arinzon, David wrote:
> > > > >
> > > > > Thank you for uploading this patch.
> > > >
> > > > Can you please let me know (explicitly) if you want me to send a
> > > > second revision (when net-next allows for it) to remove the 'struct
> > > > napi_struct' and add a comment as described above?
> > >
> > > Yes, I would appreciate that.
> > > I guess the `struct napi_struct` is OK, this way both functions will look the
> > same.
> > > Regarding the comment, yes please, something like /* This API is
> > supported for non-XDP queues only */ in both places.
> > > I also added a small request to preserve reverse christmas tree order on
> > patch 1/2 in the series.
> > 
> > Thanks for mentioning the nit about reverse christmas tree order; I missed
> > that.
> > 
> > I will:
> >   - Fix the ordering of the variables in 1/2
> >   - Add 2 comments in 2/2
> > 
> > I'll have to wait the ~48hr timeout before I can post the v2, but I'll be sure to
> > CC you on the next revision.
> 
> It's not at least a 24hr timeout?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n394

Ah, looks like you are right. For some reason I had 48hr in my head;
I think I usually wait a bit longer for larger / more complicated
stuff, but in this case 24hr seems OK.
 
> > 
> > > Thank you again for the patches in the driver.
> > 
> > No worries, thanks for the review.
> > 
> > BTW: Since neither of the changes you've asked me to make are functional
> > changes, would you mind testing the driver changes on your side just to
> > make sure? I tested them myself on an ec2 instance with an ENA driver, but I
> > am not an expert on ENA :)
> > 
> > - Joe
> 
> I picked up the patch and got to the same results that you did when running on an EC2 instance.
> Thank you for sharing the commands in the commit messages, it was really helpful.
> Correct me if I'm wrong, but there's no functional impact to these changes except the ability to
> view the mappings through netlink.

This doesn't change anything about how the driver processes packets
or handles data or anything. It's a "control plane" sort of change;
it allows the mapping of IRQs queues and NAPI IDs to be exposed via
netlink from core networking code (see also: net/core/netdev-genl.c
and net/core/netdev-genl-gen.c).

This can be useful if an app uses, for example,
SO_INCOMING_NAPI_ID (typically used for busy polling, but not
required to busy poll).

A user app might design some logic like (just making this up as an
example):

  New fd from accept() has NAPI_ID 123 which corresponds to ifindex
  3 and so thread number X should handle the connection, because it
  is pinned to a CPU that is most optimal for ifindex 3 (e.g. NUMA
  local or softIRQ local or whatever the user app wants).

Without this change, user apps can get the NAPI id of an FD but have
no way to know which ifindex or queue it is associated with.

It also allows user apps to more easily determine which IRQ maps to
which queue (without having to parse, say /proc/interrupts).

This can be used for monitoring/alerting/observability purposes by
user apps trying to track down the source of hardware IRQ
generation. Say you are using RSS to direct specific types of flows
to specific queues, knowing which queues are associated with which
IRQs (via their NAPI ID) can help narrow down where IRQ generation
is coming from.

Overall: there's a lot of use cases where exposing this mapping to
userland can be very helpful.

