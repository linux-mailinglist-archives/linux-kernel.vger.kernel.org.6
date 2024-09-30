Return-Path: <linux-kernel+bounces-343256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723779898A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FB01C20E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AC3209;
	Mon, 30 Sep 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAx8VJne"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2A137E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727656687; cv=none; b=DmNnDXqqU8exo8foiWS1VwzDB3uMOwZwUwYOte0NvOvrdzq6CjO9oOevEVqj/nURRwGfbzArh+iiTyeEI+9cqdaby7j/xu0+GpqM1oPc7oqQUE+Bx1wwaY47OBE316znnfuJnW3kFGmuPvGf9T6MRON4o+EIFyasvBXzUdBH6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727656687; c=relaxed/simple;
	bh=JaNGBaq+xeJOrFttrliu+e72cbPEjFu+j7ZRrWvmtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giW8ClYtREK6Mk3p3RzYoAQZirzT5BpGb5aar/d6SjfOQxXtnQdkM/njfdNYN/8n0bMUHe9DMjS0M3ZnQj1JPyK253KWIGqIKtpQ4YUyr3taqPm7tZxMIZuT+oOkBczjFcvvlKYDA81MxFTXUytKwILt+RlcTRxiTiw74OBAM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAx8VJne; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b833f9b35so3104685ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727656685; x=1728261485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7twIidJie4fmS/Eu4BMmjKcW5YdUcCgt6s+OdNS8q24=;
        b=VAx8VJneP52hcOHOVsP1drEd0uMNf7uW+iF8TSQr2JKEcXWmfBWMrr1E3V7Jy3b2I3
         XMDFxoBCkUC3VpMavTljHP/snRKGvWWoT8odclMUg7GOJKXosTGhoFl2NyC97GMR16RX
         xJCQbleC5MX+zHYSlFpIIsDTsJhmEMOaWNOMdOemCp/+z/ta8JJAYS4jZS2GqAdD1p+G
         FpG3oF61D1wRmP0TPRUpjvE9KUNtPtqMTAq5IdOan2i7BGJa5Y1Dme5hCHnNTs0Bw0iX
         wFZPb1Yas5UiAutlS/GTNJhhOBqewOYIH7UTFVjQlfVFD34NsEE0/gstNErm5okbfFIJ
         jS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727656685; x=1728261485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7twIidJie4fmS/Eu4BMmjKcW5YdUcCgt6s+OdNS8q24=;
        b=Kr1VpkqYahyBLBwhtSUBkRyyNt83VFGzpZxhpV/TfQF3NOhiclMTluTEewwvHJF6hi
         xwoaAPapg+xXLddFy0YDS1ggzRGKPZydFgJquttinkW+ZCyTEjnF29U8mXJOWN3i2yAq
         WtesiTS+SlhMzHySTWghVn05iWA3KbMEZGiVJXREqI8AFWHDFfJffw8Wr/JCVm9bPkgz
         YeWsfTtN+Q+mU89VFs2I34BEU7InU/G2uvLwDqWBs+sct3KBsj40FjW9/TB/QbT4fN31
         TFNaTnPkvO2ZLTmUsxVJ2pTFc1O8aFSdF/UEgso4IhAyIPu3SyjEQZ0pE7GRPopwxitq
         KIPA==
X-Gm-Message-State: AOJu0Yw42CtFKVjTRSQbjOizrkKWkNHvRK/hgsFoXdv2tonf2zvn7lZR
	5twh2CtIn0Mf3k6mXZp7dZiTMYWUPrsGvxpx7mJap+fWmJzGK9qV0kS62Q==
X-Google-Smtp-Source: AGHT+IHsvGvvU9XRDnXTt6uxZzc9tPFpyr1MqC1IbVLxWC73DOvK1yAnSvkGbvrrZXfvZetk72sgQA==
X-Received: by 2002:a17:902:ec8e:b0:20b:b21:10a with SMTP id d9443c01a7336-20b3739439amr144175765ad.32.1727656684621;
        Sun, 29 Sep 2024 17:38:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e200f7sm44733285ad.167.2024.09.29.17.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 17:38:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 29 Sep 2024 17:38:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc1
Message-ID: <d75c8f9d-8b3f-4d3e-996c-bbb9a6c240c0@roeck-us.net>
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>

On Sun, Sep 29, 2024 at 03:51:43PM -0700, Linus Torvalds wrote:
> So two weeks have passed, and rc1 is out - the merge window is closed.
> 
> Despite conference travel (both for me and several maintainers),
> things seemed to go mostly fairly normally. There's a couple of
> notable new features in here: For one thing, PREEMPT_RT is now
> mainlined and enabled as a config option (you do need to enable
> "EXPERT" to get the question). For another, sched_ext also got merged.
> 
> That said, the bulk is - as always - all the plain old regular
> updates, and that obviously means drivers dominate. We've got about
> 55% of the patch being drivers (and another 5% if you count the dts
> files). Add in 5% doc updates, and 10% tooling (mostly perf and
> selftests).
> 
> That leaves about a quarter of the overall changes as core kernel
> code, split between arch updates, filesystems (yes, bcachefs, but also
> btrfs, smb sever and client, netfs updates, xfs and finally core VFS
> updates mostly in the form of 'struct fd' re-organisational cleanups).
> And MM, core networking, Rust, security layer updates etc.
> 
> A little bit of everything, in other words. And nothing really looks
> all that strange. As always, the summary below is just the log of my
> merges, there's too much to list individually (some stats: 11k+
> regular commits,  850+ merges, 1700+ different authors).
> 
> Let's get the testing and calming down period started, ok?
> 

Fails to build on big endian systems. I'll send a patch in a minute.

Guenter

