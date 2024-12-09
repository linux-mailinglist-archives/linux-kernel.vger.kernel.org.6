Return-Path: <linux-kernel+bounces-436876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951E9E8BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB971619CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD921481E;
	Mon,  9 Dec 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPS4tH1o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272022C6E8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728736; cv=none; b=jV5nCh1tn9Tmy6vIylbcJPhF0Sm0RwKOqy4OTwTeQXwyIcBHoLMVCdBCEe3uftnm4i1JyrP9r8d2/sBNSWQcBg8Ro8GzTMUz2WtAxzlmU9K9USDNEX/a5u64zfpkUZnCT4vY/NJuNOK9aC6c7oTY/Bdq4/uOdJSSw4WH7dEVWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728736; c=relaxed/simple;
	bh=Vb03s+nk6/8EAeECMKmEZF2Sh7fR454RF+vXcSLdpkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fV2JYciqrz8/KESCO8YIWzHS6Tr/gek3S8/40s0rNkAIdIkyXfb2VMg9KpkH8hSZr14mDURKSNFL8XH8HHioj70+SjyGSCQk+MNYUePnTA54uVH3UyXWqVDwj79RbuQfGjLDee7mRwyhMNC6upXeUYhR3Zi1SlrixoBgYJO05Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPS4tH1o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733728733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oChurHVSkauDMO18eKSyKG4OEzF5P4DWu/eGbZgcy2U=;
	b=iPS4tH1oVnx3yK3lIH3TqkQ8xU+LwIGtE8YwYebO4660VvXMdxUyR+ZmfsC9IKpJcqfZc9
	NYIsrtuKKZEIUodPHEY/k1WjGqyH+FeNQRLBekDUTYrRVundUpIJdD4rCJxZCvYgquDES2
	V8p3I1dbeGRNDRp7udER9OSm65asU5Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452--q7ZalXEOdehZAB99aJJcg-1; Mon, 09 Dec 2024 02:18:51 -0500
X-MC-Unique: -q7ZalXEOdehZAB99aJJcg-1
X-Mimecast-MFC-AGG-ID: -q7ZalXEOdehZAB99aJJcg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3c284eba0so2940833a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728731; x=1734333531;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oChurHVSkauDMO18eKSyKG4OEzF5P4DWu/eGbZgcy2U=;
        b=SFDkESeNRKUlcE7Famf+UBMAipwfEPP+ddA/4uICatlG5K99hMgrfEGi0NzSo6YOf4
         LXb3Lp29dnVl+2kS/FQ3DWTRcmMIgc4o+wXj6GGRPO4CmHHYFxbvNVUIJtnc6d+KEZQJ
         H3MIIqyYhIBDOq7n+q+eaOqmv9PNFkDDAHVfvFBrG6/gbwAJgtGECamUQiv5CXjtMRzo
         YdrwRfwLCq0NTbh5vD1mhIea5E8sOPuF2hes36Ypps5zqMEUB3XoEw5cwdLhRnznCrEx
         WTo1Q6u9pewfd3f4sYd4Z6ic7kdSmbAXWMzYU84Xiqmkc6iVftdbdCLy/NjG6sZczXI4
         upzg==
X-Forwarded-Encrypted: i=1; AJvYcCXjgmGMYWkOeElyigBwcLbztvkIMjrcpbcazVRK2hEem/TM9oIcxpn8tpkCYVwpLYCLJ2MR2GjNWCMxMFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+9anMjK+p7VaWOGQVr80w0VSnV3EqlpOhzolEZ4DTnm/Hlu/
	WySSoLIY7rGtnb3JTeFy2QLTv9p6TPSW1eUUqvjsZ9e0TgZoOS8+b36ZYYKZt1kpROj6j1pF6MT
	vnWUslgwMxrdN9BCIJG1bb/krLNWWIei0MUf8qwonbHBH50a2aE1O7CW2pUzUfqz74jFyOIX7w6
	icIVEQpjmw881K3Deo4LA2PNh26aNhMIBWh9iF
X-Gm-Gg: ASbGnct+M97cYoLfAlEXembW6q0PjltMbx+Tf56mS6sEZsjKRFXk73PvLGRmaqMXJuk
	ZrLi/I1FXLsegaj4CftL8rjiREJFunBl6o/z+wFcAh0/Hz4dJWveht+SYur5bZDh0EA==
X-Received: by 2002:a05:6402:1d12:b0:5d3:cdb3:a60 with SMTP id 4fb4d7f45d1cf-5d3cdb312e4mr9768540a12.34.1733728730716;
        Sun, 08 Dec 2024 23:18:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsp7AJS0qpZNzqZAdJV798O8LFk9ku2pvgDSLygky06Rxs1+YXlIu9kKO6bOLi3eOMTsUqmPoKFA8Yunqx6ek=
X-Received: by 2002:a05:6402:1d12:b0:5d3:cdb3:a60 with SMTP id
 4fb4d7f45d1cf-5d3cdb312e4mr9768521a12.34.1733728730349; Sun, 08 Dec 2024
 23:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114195521.3073881-1-costa.shul@redhat.com>
In-Reply-To: <20241114195521.3073881-1-costa.shul@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 9 Dec 2024 09:18:14 +0200
Message-ID: <CADDUTFz8=dm6jRrbd2RLK1+aDZik_W_-HJPEdND9auRr79h6RQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] scripts/tags.sh: Tag timer definitions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	=?UTF-8?Q?Ren=C3=A9_Nyffenegger?= <mail@renenyffenegger.ch>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tag id, defined with DEFINE_TIMER(id, ...)
and ignore usages of DEFINE_TIMER itself.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b21236377998..7102f14fc775 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -188,6 +188,7 @@ regex_c=(
        '/^PCI_OP_WRITE([[:space:]]*\(\w*\).*[1-4])/pci_bus_write_config_\1/'
        '/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
        '/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)([[:space:]]*\([[:alnum:]_]*\)/\2/v/'
+       '/\<DEFINE_TIMER(\([^,)]*\),/\1/'
        '/\<DECLARE_\(RWSEM\|COMPLETION\)([[:space:]]*\([[:alnum:]_]\+\)/\2/v/'
        '/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]\+\)/\1/v/'
        '/\(^\|\s\)\(\|L\|H\)LIST_HEAD([[:space:]]*\([[:alnum:]_]*\)/\3/v/'
@@ -260,7 +261,7 @@ exuberant()
        # identifiers to ignore by ctags
        local ign=(
                ACPI_EXPORT_SYMBOL
-               DEFINE_{TRACE,MUTEX}
+               DEFINE_{TRACE,MUTEX,TIMER}
                EXPORT_SYMBOL EXPORT_SYMBOL_GPL
                EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
                ____cacheline_aligned ____cacheline_aligned_in_smp
--
2.47.0


