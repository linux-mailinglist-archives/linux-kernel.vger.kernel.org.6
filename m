Return-Path: <linux-kernel+bounces-400115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797689C0924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE811C22C10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3552212D12;
	Thu,  7 Nov 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CQgJF8Zj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188C1E049C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990630; cv=none; b=shKpIGliTGO7M4RaCOfULGoaKd6iimklqV4l6QP5YykXKBesWrwOb99Emp55RB9eEySnBNOZHYhkKO5riIxjiStMjkxJe5A2+MDoRFz5rLgp6Bc/dmu4HHomgRWgP2rlO/+Tz5DcGTnSD3r1mWJkzarvXEj/cpmQynHQFn25C2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990630; c=relaxed/simple;
	bh=u/UibkWukm8QVSh5GSo+c+62ziGUL4DF2iQ/BqbFg1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlz9FS7D8Wb9i+SDXVgTMgNReyn80SPm97EcVDuShiet9wmPKNVQLIihzLrCgiUgnntF4xB5pXZTbfpymEuvxhwuc05uvjIX7b7TCEEpAiXCQTZTmjHqs8hUj8g8OBMPQ3Vw1zAijvtnoOgjz5aeu2WhAeQ23sfHmiEP8tJPi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CQgJF8Zj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d41894a32so675390f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730990626; x=1731595426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3cGH6XjgAeljYo8IyTePdbXv29oLDJnLSASBiasK6k=;
        b=CQgJF8ZjW7z+XNziw5C67PhXckA68Y9GH93kK0NplJ9HPftB3LA8vRXpDC0kLrCvlK
         fx9qaV61oEe2wxHObaEPPqhACCBz97PTYIj9P9CdCx612+P6marjKQ3UYMd2c67a5zQv
         HRPf6Li/qZv+rffwXUVPx1Wq5Kt96XA153uokkNV+nifKnnmwiSx847KuIiw6Ow6cDHh
         8BrK5oRQolAvi5Iif580q0d8hYKZT7f+2r/gpZOTkIELQli5GiFqoKs7eMnCzKi7z5hq
         lOYsxQUD2NQXry0tk8/L91iqen0Adf2C3Qq6gyQFtx1fgK1xNCvyM8M1psUT/FAB3CdT
         +l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990626; x=1731595426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3cGH6XjgAeljYo8IyTePdbXv29oLDJnLSASBiasK6k=;
        b=eSmorGsEsz+UD8GIAApS+qOj5EkWdBXOJWwb5ulfd9Mtn8uKM29TUcjbPwi3koVnPI
         xu5m3am9lbImqO2kRouYSL2NcmxGu9SCU2l79YSnlTcy3zJicOUKxL2xgMhe0fe+FyVi
         j9+2vmtgNelv9qUfSpTPd2a/dxQ6NCShFRUv4LFv/UALAAM+nmKmXOQqKahfW/Y7aoDk
         5SM1qJgmPpYRCorCHOFknAp2SMAdQyJ0g6WAgYtuxkzTV4fTyrAIhvfihinSxBRsNkgB
         ytOj4EnHmUFW3KQN9FUHA0ACDpTVfIx6sQVUTyLDPXxBYbBfZ6luZ3UciE8SnYBSqZim
         gUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7JPpYif6HKx+BAldb8oW8AFBYgAj2rdemyBMhJpHDByReLEL5p4vtlvGZHmQxDdKWZqdekvVjV7oAGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDh1voswHTh7Z6RzcBpvAMLgTNwbbScn+1EOE/4XCbHvm00ueT
	P4CFH0DnbB0pRS70FV4sWLskeVWUi7IDj3uTdB+Q9SJ9DfDWB2bKLu4naUlqSl4=
X-Google-Smtp-Source: AGHT+IGhzDR7keUmd6bQp19ov+4IRWvETVRPa552MarSidF2G2tCRWC9KHmpiAN33CFuWpsfUB76gg==
X-Received: by 2002:a05:6000:1a88:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-381f0aeb76emr176470f8f.20.1730990626513;
        Thu, 07 Nov 2024 06:43:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda0604bsm1887520f8f.105.2024.11.07.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:43:46 -0800 (PST)
Date: Thu, 7 Nov 2024 15:43:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: metux <metux@gmx.de>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/4] printf: Add struct range print specifier
Message-ID: <ZyzSHxq8WuPp_Ewx@pathway.suse.cz>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <18854680-4ab7-4453-85ff-78351d4d4ec9@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18854680-4ab7-4453-85ff-78351d4d4ec9@gmx.de>

On Wed 2024-10-30 11:51:54, metux wrote:
> On 26.10.24 02:46, Ira Weiny wrote:
> > Support for the Compute Express Link (CXL) Dynamic Capacity Devices
> > (DCD) have grown a number of uses to print struct range.[1]  Support for
> > a printf specifier '%pra' was being worked within a large series and has
> > garnered a number of comments and discussion.
> 
> This is just printing out hex dump of a memory range, correct ?
> 
> What I'm looking for quite some time is a sane way for dumping structs
> in a human readable form (field: value pairs, using their actual types
> eg. int vs string, ...).

You like to print it similar way like "gdb" or other debugging tools do.
Do I get it correctly, please?

> Any idea to do that in a generic way ?
> (potentially using debug info ?)

I am afraid that a generic solution would really need to work with
a debuginfo.

That said, there exists some generic approaches for printing various
values in the trace code, for example, see

    Documentation/trace/kprobetrace.rst
    Documentation/trace/events.rst

Best Regards,
Petr

