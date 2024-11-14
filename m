Return-Path: <linux-kernel+bounces-409792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F99C91AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEC71F226C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024519CC0A;
	Thu, 14 Nov 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhEOD5+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50013A265;
	Thu, 14 Nov 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609081; cv=none; b=E9HCeQQa17s6YgjE4mCw4AFunIPIpOC98i9/knKlJUJZLmPKy0tmhen0kuAV6892w0cdIV8oYX7T7DxRjgLilDb6YB/wQKyYh1bGr9tT0HhSciMj8/lZhotP/qWhbYlioKvr7FBhQaOk6bSkDPRYtNGonPfdWenLfGKBU+YODq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609081; c=relaxed/simple;
	bh=iBL8A9avH89dZDTRdVja18gmbk62Z8xRk5JRrrt0Wbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV6xohnEvJQeKEUXmIhY5nSJycgYgdVwFLexJp4k41TzQL9YS9ZIqy+ET7+e+J9SafNsHeQW5gDDP27Xlof0X+JF3O0NuYeTsLdWVYoStOL+3ZCfqn+aMO5+6zqg8WKNemaWIdrua7c1bOKgTcVz6soJog4k0uj24ouTd2CRbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhEOD5+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D5CC4CECD;
	Thu, 14 Nov 2024 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731609081;
	bh=iBL8A9avH89dZDTRdVja18gmbk62Z8xRk5JRrrt0Wbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhEOD5+kO7h9/BKXZbQacm5/rSGqCVMIB7hk4zkztz+aDnEonyCVD0m5Gn9Hfxef3
	 /T5Y7suyxlu6GXbdQ9AVOrrQgiAvmmu4WuJECEg8Q23A4R9Tlp2VDMGieH9pOL/fPF
	 CjJMq700a5WV+wMO3cTdnuKOhmsvAOB2KpEZUJR4zx4r91UAI2Ms1NW7HWF8RCWSg7
	 6GarBlEMz3g43ewPra7/dD1A5ePblxERRp4xypdwQFiMBrvMFYSWY32Xz3WcJYLTrW
	 tPDdIZqVEYckoD3NITJC/QDBiSSd/F8CJSl6xvoVbElS8vnGadNyZwi4ogAuuHgd7Z
	 M2khqxzeV1t2w==
Date: Thu, 14 Nov 2024 13:31:19 -0500
From: Sasha Levin <sashal@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 5.15] udf: Allocate name buffer in directory iterator on
 heap
Message-ID: <ZzZB9-DX7IWbfSXs@sashalap>
References: <20241113043050.1975303-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113043050.1975303-1-senozhatsky@chromium.org>

On Wed, Nov 13, 2024 at 01:30:35PM +0900, Sergey Senozhatsky wrote:
>From: Jan Kara <jack@suse.cz>
>
>[ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]
>
>Currently we allocate name buffer in directory iterators (struct
>udf_fileident_iter) on stack. These structures are relatively large
>(some 360 bytes on 64-bit architectures). For udf_rename() which needs
>to keep three of these structures in parallel the stack usage becomes
>rather heavy - 1536 bytes in total. Allocate the name buffer in the
>iterator from heap to avoid excessive stack usage.
>
>Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Jan Kara <jack@suse.cz>

Your S-O-B is missing, but also it doesn't build:

fs/udf/directory.c: In function 'udf_fiiter_init':
fs/udf/directory.c:251:25: error: implicit declaration of function 'kmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
   251 |         iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
       |                         ^~~~~~~
       |                         kvmalloc
fs/udf/directory.c:251:23: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
   251 |         iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
       |                       ^
fs/udf/directory.c: In function 'udf_fiiter_release':
fs/udf/directory.c:315:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
   315 |         kfree(iter->namebuf);
       |         ^~~~~
       |         kvfree

-- 
Thanks,
Sasha

