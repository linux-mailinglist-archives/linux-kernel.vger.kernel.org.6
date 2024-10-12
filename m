Return-Path: <linux-kernel+bounces-362506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8B99B5BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07820281570
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578E1946CA;
	Sat, 12 Oct 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="cBFjMw7o"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856C1547C0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745457; cv=none; b=CEZYMulZhLKdDqL/QLzk4SJb04gVCPvs7XDaBp6ORYUEqsA/kML8ARUhOGgoGI9f+CZMEDBnmGbvcHj+VRF5fOKXgaKc/XMqvl5GdGrulX4If5nVlg5wTnf7sTtGhPFUAIGn2j2z+pTQtyQ3JAV1CnusCTUxObZi+O/KflERYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745457; c=relaxed/simple;
	bh=CcScKOT/bGfKxDcM2dDN0KWDpZ7/aD13krHQMQfkDtk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CU5U15tA4ElMbTm9JBWv/vvF0kuBgQgi+Xw6Far2EY+umOI9p/g+SVAgx/h7vJeN9FVbsiAALh4Eh6yQTwaiPKloiabD+GiPsBKj8HEEndSeRb0TrYSaOH22np2mIQUNt8I6ijIe2cT4NKeTVeCfGO0G2WSvV4+vsRYT0mVDYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=cBFjMw7o; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf693d794so10980286d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728745455; x=1729350255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nph+mclCXtR1xNVYmB2f5aDvXOCXqRK5sZg16zueR3I=;
        b=cBFjMw7oGQERyXUSMnptgGiDhDG1Pv4D000QSDco7w3nebAOOSzZbWz2l3Nilvi7IQ
         w7KP7RmVCHz4533QTMlHkE1eHKkQ9reuT1j1lyNyJM5iGg6W7cfsfdJIWnjjTt5u2Qzd
         Q0sTC7/UxOn8zWPWnEHe04ORKFdJaPiPlpVqmbcbsJ2cz96sVCW0lijlhEbQ2xLoC6eW
         kJLscmoF945CjDlHgfm/YJgzse4yau4Ko+nNwf8TD/lc9clWozbcCDv6yJgAUr8HJibB
         cfi7ejHcQDH0s8O4eyvD1Ca7kLpOvTesY1nlXqYHN4LgzOFLM8qD4pd07vW6vzGTDlp1
         F87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728745455; x=1729350255;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nph+mclCXtR1xNVYmB2f5aDvXOCXqRK5sZg16zueR3I=;
        b=WX3KzCh4hj/uZ+Bb/G/O4ktnEfN/9GwsEFfJy8s5Zh9Jq/agHCud9xnh+8TZRHY8th
         bJpb/6h0Jne0Kb8mYHReD+V+58bFHBZ2XJcD5oDGg+tHXwILaQN10tiIRVtdly4blfTq
         sXokfipWVBiiT3a7tKcnlqDN94Uo5JWUYoNFQ1foVqasWSzzXdcy8nX1XXmilaGOfkcG
         ZDoimUYmcLrn0xPg2MtCZ0fhArUpcsYpJGJZHgTZxgbj5EhQ62vBmeJ7XBuROcfKu0Ey
         A2HLFg924GlYoOOVpjO0qOs6rVV4UUgzlRpuS51RoyegNMbqa5w+P6eqLHcKEAq5RIZF
         lymA==
X-Forwarded-Encrypted: i=1; AJvYcCXdY6VGYcpH3XoIYSvn1dz7URFDsrkiNib8OmUQlc3lC9ppre9OONJ0QPurWNWvOWAyfqTYeDt8Xkgvttk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dCameZxUPrEhsUV0EffhwE90SgXALvAZPoq30GigHXCWB8x5
	z7/u2URpYTvx7DHRqPI3HBSuSfrNk+xoAHHLSrRowwmxk1ALeYDj5xESV7XYxliXFA6svpYjNR5
	ZOsU=
X-Google-Smtp-Source: AGHT+IFiXcmpIk4eF2fx4bC/AeuonOFRkyUs4l8I4zMG+W4BXZWcffuN6J2+V1f4DXWa5Hv43fDjxw==
X-Received: by 2002:a05:6214:62f:b0:6cb:ee9c:7045 with SMTP id 6a1803df08f44-6cbee9c7dcfmr114226706d6.2.1728745454838;
        Sat, 12 Oct 2024 08:04:14 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608bf1sm25874166d6.91.2024.10.12.08.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 08:04:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20241011224812.25763-1-jonathan@marek.ca>
 <20241011224812.25763-3-jonathan@marek.ca>
 <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
 <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca>
 <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
 <a6d0d8ae-3cd0-9888-abcd-1db5ab1df011@marek.ca>
 <CAMj1kXH_YbTR9xe7G=ZfqhZ6aBFE8O-ghUe8asd3qqEUN7vdUw@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <149af6cb-300c-af5e-2a91-161be0dd4d43@marek.ca>
Date: Sat, 12 Oct 2024 11:00:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXH_YbTR9xe7G=ZfqhZ6aBFE8O-ghUe8asd3qqEUN7vdUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/12/24 10:50 AM, Ard Biesheuvel wrote:
...
> 
> Right.
> 
> Would the below work for you? It's not the prettiest code in the
> world, but at least it keeps the weird local to the function.
> 

Its missing the "load_options_size == 0" case, then CONFIG_CMDLINE 
should be used even if FORCE/etc. are not set. Otherwise it looks OK. 
(cmdline_len also shouldn't include the NUL character, but I don't think 
that matters)

> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -189,26 +189,48 @@
>                                    unsigned long *load_addr,
>                                    unsigned long *load_size)
>   {
> -       const efi_char16_t *cmdline = efi_table_attr(image, load_options);
> -       u32 cmdline_len = efi_table_attr(image, load_options_size);
>          unsigned long efi_chunk_size = ULONG_MAX;
>          efi_file_protocol_t *volume = NULL;
> +       const efi_char16_t *cmdline;
>          efi_file_protocol_t *file;
>          unsigned long alloc_addr;
>          unsigned long alloc_size;
>          efi_status_t status;
> +       bool again = false;
> +       u32 cmdline_len;
>          int offset;
> 
>          if (!load_addr || !load_size)
>                  return EFI_INVALID_PARAMETER;
> 
> -       efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
> -       cmdline_len /= sizeof(*cmdline);
> -
>          if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
>                  efi_chunk_size = EFI_READ_CHUNK_SIZE;
> 
>          alloc_addr = alloc_size = 0;
> +
> +#ifdef CONFIG_CMDLINE
> +       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> +           IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ||
> +           (again = (IS_ENABLED(CONFIG_X86) ||
> +                     IS_ENABLED(CONFIG_CMDLINE_EXTEND)))) {
> +               static const efi_char16_t builtin_cmdline[] = L""
> CONFIG_CMDLINE;
> +
> +               cmdline = builtin_cmdline;
> +               cmdline_len = sizeof(builtin_cmdline);
> +       } else
> +#endif
> +       {
> +do_load_options:
> +               cmdline = efi_table_attr(image, load_options);
> +               cmdline_len = efi_table_attr(image, load_options_size);
> +
> +               efi_apply_loadoptions_quirk((const void **)&cmdline,
> +                                           &cmdline_len);
> +
> +               again = false;
> +       }
> +       cmdline_len /= sizeof(*cmdline);
> +
>          do {
>                  struct finfo fi;
>                  unsigned long size;
> @@ -290,6 +312,9 @@
>                  efi_call_proto(volume, close);
>          } while (offset > 0);
> 
> +       if (again)
> +               goto do_load_options;
> +
>          *load_addr = alloc_addr;
>          *load_size = alloc_size;
> 

