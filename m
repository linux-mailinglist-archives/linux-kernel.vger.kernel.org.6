Return-Path: <linux-kernel+bounces-254558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002EE9334C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218C41C22606
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B26A3D;
	Wed, 17 Jul 2024 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTEW85Nl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7C386
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176477; cv=none; b=neQpX6QbGCFWxVMaTDPqS3tvSzq1qxiU4nhCau++Dv4/fyOYx7ul9ebjmev5Jx80Pz02P3A5zq7KyZbpBOZPLpClCWdqOQSwSCIYytMWzS/PqXkSHx6i7TUDBTf1CzzLhjAR4Tp2+ArU0cgzrOKZ8RYJKm2D5is00XIXB56cN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176477; c=relaxed/simple;
	bh=+ifN70K/2rwVAJTiypDsMBq+yPgPipDxCaDjw6IDStQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKAnp20A3K4dKmP0BZYkBu99q67/fvqwy+/FrUpEFAXA3+jFle/qPFUbiqDGDGMXQX/1C3rguRzeUCRxxGml1esOUbmcp6JDM3NxuM1pp8BpriD5JozYb+qXEg/cSBR8QXSrei03p5Cy/rmV3mNk5HlmyiP45oJGTNoJgLhu7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTEW85Nl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eee083c044so42104441fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721176474; x=1721781274; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zuhlq7fqc5zowHNadjoSQU08DZaciLqgvw8GFRTA7nI=;
        b=jTEW85Nl9dXgfHRw88CoS75fGYJZ8NzCt1u7HdC09D+7i03JFRp+ehlL3Gc60DRuGJ
         rNOj+eNdYMmpVa0JBW/RGQqXlBd0md8N/RwsNBUeTGkYr43TchgcABDElYZOFTS5GUR2
         7OpnqZMjtQJVgHMPrTKlxwOJsMQPaqDBDEKpgPFwaZUJKfmvdwprmkJoAAtdlghhInCU
         ZgXDx3xH1g0RUt2W8aW291xSx23ZAG331/cjx6kKP+fP6YVQiPth77D2FO732PSKwgXF
         3xCcHz1npNmMBFaHE/PWnkCGPWFcC1FxTWlFGAx2EF6xr98fRp3sZbx/4w2WlCvSs86h
         6+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721176474; x=1721781274;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zuhlq7fqc5zowHNadjoSQU08DZaciLqgvw8GFRTA7nI=;
        b=p1lrrm878ayUP3+OaKyZedB4A8JRffa4cXHxmCllG54yiC86hqfCVJfPZupXZUTeMy
         hkQGNVlm3NL7YdRRnTXxOitaJAU+rOcaKl5fGRNoFBpaV4r+mXxchTEmG+91k56qJjkR
         x0WdMPTIEUmbvEHcY4TPAvOTF6q5xwV9OoeNMpk4mCmjZLQ3aElfK9xORBMYLMwgvgkm
         YnMzKMsR8lED2m/vnYPbnsU0T5MmMKJ2xYQazfLue6YlllVrGbrNuUBzKr/zxSGdomFS
         jxpc8KhZPurZELH6O0p+zONs8ZcY5VosxaMP1xsFholcySyaP8I03wGNvNzpoTgA6ow6
         n4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCURYDMXQssenwARS7gIHtJOLCT1xGWpkvjbqBRK+dRw8Jd/SlL2s/JrjgOLDkPE0jxvP091whQRGkQC5nnBr19iS4Cz/f8wgf2zFq6H
X-Gm-Message-State: AOJu0YzffjMSPnlNB65NHMkAOQ5kynl8bVmmV+ve0l2Ffqvtznc2C63/
	d/J5mskthWnbDVh83emWvvhjyzQsy+Qa8kakXIO+ELxX9AjULq/d
X-Google-Smtp-Source: AGHT+IGO893mZyPdiVFsjBQd/kjdxdUKfwUkq2GAWNt49q8e+yuAYKoxnyupKoKP2nG+nWCabONmNw==
X-Received: by 2002:a2e:8e34:0:b0:2ee:7cd0:a193 with SMTP id 38308e7fff4ca-2eefd0ae41fmr785361fa.22.1721176473646;
        Tue, 16 Jul 2024 17:34:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24f56d24sm5838565a12.23.2024.07.16.17.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2024 17:34:32 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:34:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <20240717003432.xbb3zs3iednce6vf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <20240716021543.ghzeiq5yqtov43lk@master>
 <ZpXbalVnI9FzHMHx@casper.infradead.org>
 <20240716075609.rlw523szys2jztpy@master>
 <xhshclihkl6d6bbh2f67yuo6qalwekc3qgf4hzvcibri74rh2q@a5qnddnskdm3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhshclihkl6d6bbh2f67yuo6qalwekc3qgf4hzvcibri74rh2q@a5qnddnskdm3>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jul 16, 2024 at 11:54:47AM -0400, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [240716 03:56]:
>> On Tue, Jul 16, 2024 at 03:31:06AM +0100, Matthew Wilcox wrote:
>> >On Tue, Jul 16, 2024 at 02:15:43AM +0000, Wei Yang wrote:
>> >> If you think my understanding is correct, I would send a v2 with proper
>> >> changelog to describe it.
>> >
>> >It seems like you're trying to change something that isn't broken.
>> 
>> Currently we don't find the problem because these two kconfig.h is similar.
>> The only difference is the one in tools/ doesn't include "generated/autoconf.h".
>
>We need that include.
>

I see your point, but I find current code has a chance not does do this.

>> 
>> And in related files, like include/linux/xarray.h, includes the correct
>> kconfig.h.
>> 
>> It is not broken, but doesn't mean it is correct, IMO.
>
>This is really annoying because it works today and your change was
>correct enough to look right, but it doesn't include the
>generated/autoconf.h  - so it's not right.  It took a lot of time to
>figure out that it isn't right.
>

I am not sure you have read my second mail.

Here is what I find.

I add a warning in tools/include/linux/kconfig.h.

diff --git a/tools/include/linux/kconfig.h b/tools/include/linux/kconfig.h
index 13b86bd3b746..12d3ed5f16b2 100644
--- a/tools/include/linux/kconfig.h
+++ b/tools/include/linux/kconfig.h
@@ -2,6 +2,8 @@
 #ifndef _TOOLS_LINUX_KCONFIG_H
 #define _TOOLS_LINUX_KCONFIG_H
 
+#warning include local kconfig.h
+

Then I run the command:

$make maple.o
cc -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o maple.o maple.c
In file included from ./linux/kernel.h:14,
                 from ../../include/linux/list.h:7,
                 from ./linux/../../../../include/linux/radix-tree.h:13,
                 from ./linux/radix-tree.h:5,
                 from test.h:4,
                 from maple.c:11:
./linux/../../../include/linux/kconfig.h:5:2: warning: #warning include local kconfig.h [-Wcpp]
    5 | #warning include local kconfig.h
      |  ^~~~~~~

This means current code may include tools/include/linux/kconfig.h, which doesn't
include generated/autoconf.h.

After I change to <linux/kconfig.h> in kernel.h, the warning message is gone.

Current behavior is not what you expected, right? We have a chance to include
the kconfig.h which doesn't include generated/autoconf.h. 

Hope not waste your time.

-- 
Wei Yang
Help you, Help me

