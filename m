Return-Path: <linux-kernel+bounces-266236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5D93FCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD4D1C2200C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF9183098;
	Mon, 29 Jul 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Gi8Xq6OP"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DB15F303
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276089; cv=none; b=bWkaEjjYaxTktImlYUdoguha+a5vW6U2ZROm6i4rob0yphmw0QNcCF7agAujmUwXX6ZBk8iArrU1Ck65jAJmou5fGKCfDby4y0f8hBcPuvIofitad9TcXGMJLGDRbncSwHwtN7iEaCkeugeX5B6GP73v6Lavk67xVT+XpIJ6N0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276089; c=relaxed/simple;
	bh=NxPxTGwFiATU9I0paB9I5SPNOKKKTOqx+SBrETwxHTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyClXoPHGTvuj7+zg/kkKeys/8Km9/nT8k1Xk4sveQ+7zbSJcYtf76yKILGAWFh1W7yd2V+88VPZX9pG4XH9TEvhLq0X3C8ylw+/SRL9V7diUzliIJ6I3jvhIgTzZUHdTBxMSSpMgwXcuLnT3BDgYgCxFJ/v/1FNqjYS9gQ1+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Gi8Xq6OP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44feaa08040so21676571cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1722276086; x=1722880886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nd1WXiUiTtwYxOMtFvVlG67gP5owuM6QDVES/bBhfKI=;
        b=Gi8Xq6OPZ4Y3aMQLojrKDSxIDgSOe3RPI6xt4MjEYVDrVCyhOOoNFouAJLjg3YFO46
         d4lnr1SQGaEbAIWHXtOegwYeJhL4OiWlqqSXBgoU1/AlUODDcR9poUDNNKVF47f8rdqX
         vC0FDp/1JtrnO75hsBrhKp9ITGPIjZzMFx+nlVScvfnwl+OyEEiXsQk9z5dqP8xHPZal
         D89XqyayNSW1Qdk0KPH5jxzjPe1EEjXWhC9RKbwyXG3Xn4VQaYHefeKmn2+L1YXgWaqH
         pUS1BZyH/VIZ78eyd3SQy0e3VyVAoCj/SNG0+pub3v1RGPgyr3N+xazZ7ptk9R76X7vm
         xYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276086; x=1722880886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd1WXiUiTtwYxOMtFvVlG67gP5owuM6QDVES/bBhfKI=;
        b=E1sKmxmf4SeNOyfweS03t/N0zkGhBgrMSDngMitIr8OIZ/rFiy8HLpkP59nGulWCBm
         wftSaoA9ev1WI04M9Ni14Cfpj0sygu0CZGd2Tblr9JhNPAWshA+5gE0kw7SDKoSa4sdj
         9cpNGkm7bzLsDcNOBbBMZgq6na2d1HwP++tNUzoLVM/OQPwwKONuLP2Ff0uWTa14xySs
         ehqI2UFV0aXvsSaAI/i0bin34uhs3kIRagbs7L4OVuytQSeS6Gf6yNQxMZiMO3MQGZ6N
         6MHlb+kEPRwKimoI+g+p+Z6h9y3SzBnRwW9C92H4rbtzJwVn7H//7MyQSI04wLxQb5ae
         dYKg==
X-Forwarded-Encrypted: i=1; AJvYcCXLd8PKdPjZRt0mabx/67Ju5g+A6kMv0jiqJIkVPEH7M24occA3LSIIo044qovbawQtEzDZGaabgpRlO+EeaSVI6t8rPF2XHgeYz5LH
X-Gm-Message-State: AOJu0Yy1Vadkzyrp6VHfSy8m1ZH+NYaWE2DfWiMJhM1yLI4Aocn3kron
	tfggJNStxNF546YQFyWvEvve9utUChRBYhykOXjyhqqGhlaiVZQfBj4xeVLxhw==
X-Google-Smtp-Source: AGHT+IGVjAt2ihyHs5zn4xEcJd29SKFy9xWmbX66Bk6IjnJc3rfCed+UL/M7vTEtzJwl7uv6mxhVxQ==
X-Received: by 2002:a05:622a:1791:b0:43f:fc16:6b3f with SMTP id d75a77b69052e-45004f1378dmr135514091cf.34.1722276086083;
        Mon, 29 Jul 2024 11:01:26 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8147635sm44235931cf.31.2024.07.29.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:01:25 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:01:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>, andrey.konovalov@linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
Message-ID: <d4ed3fb2-0d59-4376-af12-de4cd2167b18@rowland.harvard.edu>
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
 <baae33f5602d8bcd38b48cd6ea4617c8e17d8650.camel@sylv.io>
 <CA+fCnZcWvtnTrST3PrORdPwmo0m2rrE+S-hWD74ZU_4RD6mSPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcWvtnTrST3PrORdPwmo0m2rrE+S-hWD74ZU_4RD6mSPA@mail.gmail.com>

On Mon, Jul 29, 2024 at 06:14:30PM +0200, Andrey Konovalov wrote:
> On Mon, Jul 29, 2024 at 10:26 AM Marcello Sylvester Bauer <sylv@sylv.io> wrote:
> >
> > Hi Andrey,
> 
> Hi Marcello,
> 
> > Thanks for investigating and finding the cause of this problem. I have
> > already submitted an identical patch to change the hrtimer to softirq:
> > https://lkml.org/lkml/2024/6/26/969
> 
> Ah, I missed that, that's great!
> 
> > However, your commit messages contain more useful information about the
> > problem at hand. So I'm happy to drop my patch in favor of yours.
> 
> That's very considerate, thank you. I'll leave this up to Greg - I
> don't mind using either patch.
> 
> > Btw, the same problem has also been reported by the intel kernel test
> > robot. So we should add additional tags to mark this patch as the fix.
> >
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com
> > Acked-by: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Let's also add the syzbot reports mentioned in your patch:
> 
> Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
> Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6
> 
> And I also found one more:
> 
> Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5

You need to be careful about claiming that this patch will fix those bug 
reports.  At least one of them (the last one above) still fails with the 
patch applied.  See:

https://lore.kernel.org/linux-usb/ade15714-6aa3-4988-8b45-719fc9d74727@rowland.harvard.edu/

and the following response.

Alan Stern

