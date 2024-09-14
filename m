Return-Path: <linux-kernel+bounces-329377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59476979088
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023311F21ED1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891491CEEB6;
	Sat, 14 Sep 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBVJL7IW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5343177
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313725; cv=none; b=iH5SoCXNGoccZEXUrowWHgU6Jxr+l2JnCwmBwl68VTU6IE5jRpHYqjIIkzBFf/G3RNvV9ZeUuQxIXlMM8dGgdyY2T+LBfJsChsFbqmet5CJGAT7rMbAnVpnt2n73FdLK2v8qM4UluC7AesfOwon8D/X02LpVfd8WnQnvobYw7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313725; c=relaxed/simple;
	bh=yrUVUCO79duNPsTTGmpmbvoQlHRbeMbwbNMft8UZzfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5gzJlVCjE43k/SHx3pJqZKUV1sJ/e1LQnM7hdvEL2QaN+DCLLZSP2GVR0iJXUik791eY2Q01mQiIFqV6d1EltlG4dp3BEIbodoNiNM8dxZv7pgn1L54cBFf8059wTXWDxruqmoDEF8N1fsmX692FlHHmUZ8OCOmcgIoBmdPyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBVJL7IW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726313722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDWzsATt7aJa2rBgBdkq6jbTGGmqY54BlI5F5qY/RY4=;
	b=aBVJL7IWZ2v73rrR7Zl6oa4V8q+fBN9/LWCiUxwmqLyt/0shiuy935A2evK345jZMNXkvk
	bygDFutQpVgZAWhgp0GKJVD6Xwix/zn1dHO1RVvrtGoQmSfiyg/q70ud9JEZ6bDi7nvN0m
	Bhu43PNDB4dJ8b4Ansrd1Y0Elo9Rvxk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-QwVOHdm3MRSU_AI_f0PbiA-1; Sat, 14 Sep 2024 07:35:21 -0400
X-MC-Unique: QwVOHdm3MRSU_AI_f0PbiA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa67b1101so575181139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313721; x=1726918521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDWzsATt7aJa2rBgBdkq6jbTGGmqY54BlI5F5qY/RY4=;
        b=GZ+L8+Pw2HTAo3byLXZsUp7TegjEhVBpFIiCViQ3kpR5HqxxwFJHQlPNiUVqtlipIE
         MmtPqGGbU9d2O5SIDGmhl3QCiLe4Z9GkZpdrOAb4eIMteEqyGbzPFON8VF5VHzHPZqLy
         nkzxUPsQW4crWXHljw51zKxhiM/EWgfj0SyO9KgZXvyTFzaFTSGyrOP+q1Lbo3j/AHAa
         akegvZ60H2s0yg20ioJa9Ng+Xy9NlrIme8XT3ghWWlplOxk5PT+BJ3t+HznaIfFpHq/l
         c+h3sm1kdzGSh9aP3yNaGQXmpUFWJFr58BrdrMmpQ1+duqe0LDr9QePfGUsAUTd62Kb5
         LxkA==
X-Forwarded-Encrypted: i=1; AJvYcCXxOP7zNr0S7XMCQuR/Y2dNvKN8RwOvzBC6eSb0jKtrz6STfg5BMni+h2yhI87ZluAKsJeWdezhbttuBqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oGOmJYsV2NngTkqab8yIvOyZ57V1mmVCcKEsRxDfN8WfNxUn
	6rrPpLio7RyMi2Keul4WIUwXXaYz17pP9tS6Vuffik2+vugD/x1+yJDFHjqfHQVss8yo1U63vNn
	goj5/pEhtrgnFEtRKrXDjINiIBz6PKyPpqI5hfkygmoTnG4rpvZ8xFTPdG6O0aCyg8gUnaGFuJG
	4VOnTwUk9y7KMVUfsrbEk4o9/pWzZ8GEBuU05F
X-Received: by 2002:a92:c24c:0:b0:3a0:4b2d:78d7 with SMTP id e9e14a558f8ab-3a084911895mr104421485ab.13.1726313720859;
        Sat, 14 Sep 2024 04:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7DdPLXzBdCIfP0PRwTULiAqby7AgynlJb43d5a8t3nN14uLk0BXzE5/S/B2NkhXok8GSnQEvt9O0sSbVkHqY=
X-Received: by 2002:a92:c24c:0:b0:3a0:4b2d:78d7 with SMTP id
 e9e14a558f8ab-3a084911895mr104421265ab.13.1726313720517; Sat, 14 Sep 2024
 04:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
In-Reply-To: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 19:35:29 +0800
Message-ID: <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 19:20, Dave Young <dyoung@redhat.com> wrote:
>
> The setup_data ranges are not reserved for kexec any more after
> commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
> for setup_data"), so update the code comment here.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Index: linux-x86/arch/x86/kernel/e820.c
> ===================================================================
> --- linux-x86.orig/arch/x86/kernel/e820.c       2024-09-14 10:39:57.423551301 +0800
> +++ linux-x86/arch/x86/kernel/e820.c    2024-09-14 18:56:30.158316496 +0800
> @@ -36,10 +36,8 @@
>   *
>   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>   *   passed to us by the bootloader - the major difference between
> - *   e820_table_firmware[] and this one is that, the latter marks the setup_data
> - *   list created by the EFI boot stub as reserved, so that kexec can reuse the
> - *   setup_data information in the second kernel. Besides, e820_table_kexec[]
> - *   might also be modified by the kexec itself to fake a mptable.
> + *   e820_table_firmware[] and this one is that e820_table_kexec[]
> + *   might be modified by the kexec itself to fake a mptable.
>   *   We use this to:
>   *
>   *       - kexec, which is a bootloader in disguise, uses the original E820
>

BTW,  the conversation below drived me to read the e820 code:
https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u

It could be better to clean up the e820 tables, anyway the comment fix
in this patch itself is good for now.

Basically e820_table_firmware is used by kexec-tools kexec_load
implementation,  e820_table_kexec is used by kexec_file_load code to
pass to the 2nd kernel in boot params.

The e820_table_firmware is said to not be modified by the kernel in
the code comment, but this is not true, at least the sev code updates
the table.    The hibernate code generates crc32 checksum and verifies
it, but since AFAIK e820 table update only happens in boot phase, it
will be stable on runtime.  So we can just use e820_table_firmware for
kexec use and drop the e820_table_kexec. With the change the
kexec_file_load and kexec_load see the same memory ranges.

Otherwise I thought we can use just one e820 table, dropping
e820_table_firmware and e820_table_kexec, but then there will be
fragments and memory waste  due to the setup_data ranges are reserved
and updated in e820_table, so the e820_table_firmware being still be
used for kexec makes sense.

Anyway I need to think more about it,  please let me know if you have
any concerns.

Thanks
Dave


