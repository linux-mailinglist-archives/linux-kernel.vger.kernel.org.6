Return-Path: <linux-kernel+bounces-309680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AE1966F24
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1780E284E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE84D8A3;
	Sat, 31 Aug 2024 03:51:18 +0000 (UTC)
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081C1D12E1
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725076278; cv=none; b=T0wc2Ac5d4ZiOHudU7njSkpBZFeLa38Jvwu/9UgOs5KkMiaqKQkrxRquKwfHWnptobGT8SbsMmEmZiLzJmcWvhELwYnBRwfoCPEYhNPVTUZlw3cTieMkdQZssryD0nTBKVIeupm8eNE2mqwXrXum368L0NR7zPoJBrD4J/ZJLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725076278; c=relaxed/simple;
	bh=K3M8eVyFhjCx7eCtxqv9M74fZBNEVpX2/FbVYSmh0jg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jNBAPkPdbW9hMLAebsClPVyswMPIIdykurlgzYgel15H9RU7ih3+rr4OxnUde+kd+aY1K8imZS7Mu02NujzDEUWE9g541gbJh0Ck3fTiE5xY24cbzwWITlsEz86ce78CdxS9s5cE2mbDBc2JBbr0yi87WOvSLQBT4XCws05wbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTPS
	id k46WsNGu99TOUkF8nsRguL; Sat, 31 Aug 2024 03:51:09 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id kF8msNL4hGvSVkF8ms9SZC; Sat, 31 Aug 2024 03:51:09 +0000
X-Authority-Analysis: v=2.4 cv=FpSm/Hrq c=1 sm=1 tr=0 ts=66d2932d
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=M51BFTxLslgA:10 a=3I1X_3ewAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-zVk0zCSwmg4igyWCyAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 47V3p6w8019641
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Aug 2024 21:51:06 -0600
Date: Fri, 30 Aug 2024 21:51:00 -0600 (Mountain Daylight Time)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Eric Sandeen <sandeen@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
In-Reply-To: <ad3a24af-5366-4c20-ad46-6f21d6754bbe@redhat.com>
Message-ID: <alpine.WNT.2.20.2408302142040.2560@CLUIJ>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net> <2024081303-bakery-rewash-4c1a@gregkh> <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com> <alpine.WNT.2.20.2408181925400.3116@CLUIJ> <883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net>
 <ad3a24af-5366-4c20-ad46-6f21d6754bbe@redhat.com>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfIPQWRiluBCmXTmgfIuOQ0g5nednXkl+JVrf7VK5YUZS6HWwRuETKjcaY8KKTkYk0vzNBY+UNY7l9+KQerhsPuwHBuo6V1gq/+z0tX2QdpGH0HmQ/KBH
 Xyzkf0aWin7uPACLBSxPPSDi2YtG1RSTRAsjprZKD8uZlAoQobOxCiCKDk+1aW9BGFsx0SscenhR0eZHL9BXtvm7QeY2skpa33eLLARY/gYXHgs1EPW9ECZs
 XLJ0O6KAYGjSC3qwB4j3fihVt7lCqfQA1OmugKwGszl8wULB7PjCb7KKRsT7NTHEVJLF8rrzxcG3qwnRz3ekiwNiZwHnaiInGJUYhLI6eGrC0fx8tOJnb0bI
 v+3uEymo

On Fri, 2024-Aug-30, Eric Sandeen wrote:
> On 8/29/24 10:44 PM, Marc Aurèle La France wrote:
>> After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
>> options"), debugfs displays "none" in /proc/mounts instead of the actual
>> source.  Fix this by recognising its "source" mount option.

>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
>> Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
>> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

>> diff -NRapruz -X /etc/diff.excludes linux-6.11.0-rc2/fs/debugfs/inode.c devel-6.11.0-rc2/fs/debugfs/inode.c
>> --- linux-6.11.0-rc5/fs/debugfs/inode.c
>> +++ devel-6.11.0-rc5/fs/debugfs/inode.c
>> @@ -89,12 +89,14 @@ enum {
>>  	Opt_uid,
>>  	Opt_gid,
>>  	Opt_mode,
>> +	Opt_source,
>>  };
>>
>>  static const struct fs_parameter_spec debugfs_param_specs[] = {
>>  	fsparam_gid	("gid",		Opt_gid),
>>  	fsparam_u32oct	("mode",	Opt_mode),
>>  	fsparam_uid	("uid",		Opt_uid),
>> +	fsparam_string	("source",	Opt_source),
>>  	{}
>>  };
>>
>> @@ -126,6 +128,12 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>  	case Opt_mode:
>>  		opts->mode = result.uint_32 & S_IALLUGO;
>>  		break;

> Sorry for missing your earlier question, I was thinking that perhaps a
> comment along the lines of this would be helpful:

> 	/*
> 	 * Because debugfs accepts all mount options and indicates
> 	 * success even for unknown options, we must process "source"
> 	 * ourselves here; the vfs won't do it for us.
> 	 */

I disagree.  It is the new mount API that treats the source as a mount
"option", so to speak, despite what `man mount` says.  Therefore the
consequences of that change should be documented in the API, not here nor
in any other fs.  Besides, there's already too much echo in the comments
around this code.

>> +	case Opt_source:
>> +		if (fc->source)
>> +			return invalfc(fc, "Multiple sources specified");
>> +		fc->source = param->string;
>> +		param->string = NULL;
>> +		break;

> but I suppose it's not a big deal unless others think it is.

> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks.

Marc.

