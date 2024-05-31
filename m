Return-Path: <linux-kernel+bounces-196510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF228D5D30
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97071F21F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00283155A5F;
	Fri, 31 May 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6UlgJr0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2A155758
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145618; cv=none; b=oF0+tEKkjZaMVNyM2VgVsGobpnoxOEOwA8SE9AJRA9io/9mB9s7hzFjWeNjfllXlVzM3miansmw8Y/QibNhmSghdhgJFyzQ6j6RGDawdqHQJndSRsUWl/LinjMNPKYoyFVvK5vimXRnmAtJx7e/f3fgchwLfcRkMXqRtxCIE+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145618; c=relaxed/simple;
	bh=NovAGQAJDKQTMTAI+az5GHF58LXNrOVqVoPHaefwx2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYoc4eXHvAjiBhx/BUxupOX7kZtUmBlMv4gVFf9hMMPu8zqIvyYOC5giamo748AdZG/gq9PVyJwDvtg6PP1p5G8VXafDzjNnhjWK5C1SRssT4jauNbitolsPJGhY4HTNQZkolT0sb/nYok5NKYmRAEvgEDemx9muZcpZ8EnAzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6UlgJr0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b8b638437so300779e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717145614; x=1717750414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLysO7NeGsNXqaNuKCZ49ISqQA88jU3o40hSAdkel0w=;
        b=D6UlgJr0B7sWc+/jdtfuQTaCEFI6ij4Vtfkx3FX6r7kj9EMFeFbL42TH8i2tqSOTYn
         XG2gmvuYOBwJROIDIcroCdDCW9MyS/ZzEGvlaKkej3//pfqzDy0o5BK6QQ5Ew0BJf8C9
         WSZtdsJatfQq71+fuHo/vqStQ2JwREjW/azYSSKV72wnqbJVQgX9pYX4swTI4EEpk4BL
         0t2zCnPCte1c453Uj9h2L7/HqBgPMz/1pwHkcns1xDAqlLJvdFzrnEwHkmXGVJMbnTUm
         yAYj0di+MucAvgfA9iIV6+23X6LvVdzs+o3hW0Omzjct1M4MuSyPnFI/9pEZqbku0wcT
         EDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145615; x=1717750415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLysO7NeGsNXqaNuKCZ49ISqQA88jU3o40hSAdkel0w=;
        b=MYAa2d3+Tk1lZxyF1/LIEO9YO47Z6tfi+7nwbnJICPL2WBiFZ80xlOibKpP+lIZwjT
         FMIEwET9/W8T4D7lILcogUnySWNKOazisCmELfFZWV9kOhs2K4g7n1c6imOPIBFM/vQ2
         iOxC8hL3p2sVyIq0qkYmmCQCvAJDsFiM6EoSXH7cHavlv6vl6FCukRsc+TR12ZiekgQz
         Nib7ffRJmZZIf/NGwl8WPEgZ0V7Chkmub7xZZTjlcVR4MW4OvKFwM03oIOp4a0Qpz1v6
         iSf2/YK0kn5oVrjAXj/Zx8JCzgUaCR5B7KWjL0P8EOSALvG/6QDlK5gvEWMOscBycURq
         uFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWAXds+puGNGB3efEzOmba3yUsZmO5/9rNW28bggukywn0w/iERZNuMnpg+tN7My+U4QOqlQd7wxx7IXVRgXJazFIdjk2VXWCM7UUJ0
X-Gm-Message-State: AOJu0YzuEvXzblGP/DqNG5zYFWeeGuRqWSva5LlQ1MpjGqdaLzZiD3HL
	5W9jtdyWwzdRoQ6oruPXKrvxWReltzm4RMla4xjwderm1SGAqlLW6yRXJCYrnsE=
X-Google-Smtp-Source: AGHT+IGrI3Xg4zdtsWUBFh/C9H8BavQLRkhQTUppdMH6+mDG8k23IfbW5XCrkz8PmMS4gZWwWO0rig==
X-Received: by 2002:ac2:4e93:0:b0:52b:7bde:896b with SMTP id 2adb3069b0e04-52b8958b992mr604317e87.14.1717145614446;
        Fri, 31 May 2024 01:53:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea5869ddsm63483966b.105.2024.05.31.01.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:53:33 -0700 (PDT)
Date: Fri, 31 May 2024 11:53:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+07762f019fd03d01f04c@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [syzbot] [input?] [usb?] KMSAN: uninit-value in asus_report_fixup
Message-ID: <b86a9ef9-ea50-45e1-85b6-20b6f5358862@moroto.mountain>
References: <000000000000915d550619389e8a@google.com>
 <tencent_9FA58DAAA5CF0D8B9250DDB2DDF4192FCF07@qq.com>
 <a66819c1-1ee1-47e1-8831-c0f1a22a12c9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66819c1-1ee1-47e1-8831-c0f1a22a12c9@oracle.com>

On Thu, May 30, 2024 at 08:16:59PM +0530, Harshit Mogalapalli wrote:
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index a90ed2ceae84..9f0e09f667b1 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -1029,7 +1029,7 @@ static int usbhid_parse(struct hid_device *hid)
> >   		return -EINVAL;
> >   	}
> > -	rdesc = kmalloc(rsize, GFP_KERNEL);
> > +	rdesc = kzalloc(rsize, GFP_KERNEL);

This kzalloc() is unnecessary because hid_get_class_descriptor() has
a memset() built in:

	memset(buf, 0, size);

I'm not a huge fan of how if hid_get_class_descriptor() runs out of
retries, we return the number of bytes in a partial read.  Then the
caller pretends it was a success instead of using the result.  But
that's a different issue.

regards,
dan carpenter


