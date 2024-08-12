Return-Path: <linux-kernel+bounces-283169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683494EE29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4433F283223
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422E17C7C6;
	Mon, 12 Aug 2024 13:31:14 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1417B4E9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469473; cv=none; b=m7kggjMaspYortAC1MQ+drbfCwXPpQsl+YTPQFgdWtpFMP7SOwIHFY4Ln8tEiW4B/dlATYvjRpsFXsojabCTmuqm8P9iXNNiC1KnYxFm5wr7f7rogaY0AWNSbyFoVYlEB6811YZBQYkh71+DhnfMkCR8sANraKxKBeoOzxRnhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469473; c=relaxed/simple;
	bh=4MSDwiezBX10BpCrtnTOXjYawS7qUs3kgNVU0jPxGOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JITjo4cHZ2wkuWn3dHOdY/XLsTqlUmR4Dy78AAYfyV4sIrWm7926xdH2zZ38FWv7igiTfh++mVR6LCYx1tfkPIDXOBpGnfx3KR0U5XKMy2PAPpZb+FoPe98iD8nUBHkRqINpKQ7TS8II5a7F+cyUMzXNvsMPycqWSRD5O0FLcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so539817639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469471; x=1724074271;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2MDDwxPus6L9nBZUy+Tw4tNy6gY2TGHmSnbh9IyXkQ=;
        b=AkBC3v6oQC9bU1MKI+154cQxD9ncx6bB54J3fetTms+3pWtuekXZvdJRB3jHJxmxND
         +9jnvjJsfFeeUlyj0yhXiqxM3JNqCSFx7WNkcYUysxi9PRnwh2AiBV7kqUYTRMW45Rxp
         s58ZVusqJRlaJYjUSmiK+RpLZ3zt4bDlGzkb0MHwB2xUpcGjLa8rkNPvMtZz1CKFjN7B
         0hzSQ4ZjZSZAmsfXnUS64aae3d/jbxJmpB+k7/7iZrGnp4REgGoFKQRTxzMWHGoZRJ0k
         4oWxBXgq2BsIpZm35B+YULfJf73N7SPLhNtRB2vnxsFBdwllwqXE73Gb5WipG/GXAr9g
         lAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeXZn6jigVagrHOYXnLhLLPlYILWxq8DNpZIkFhUUhVyXtYbAaE9ffMLGBtH+8Xpuc9z+cFOu5tBsVoQ7Wfo10ZzYqfHsrXU8BbvUf
X-Gm-Message-State: AOJu0YxyzNyaKd4QFq4IaudKujHgrhVB4eMMWvp3vNxvtXjewQGF1vfD
	Qjp0DxpX3+CseHLgR0+LLbSGzn82NGdOO3tAE5N9piwVrBMs1taLEVFNjDBaA/odwbhu2PanSIx
	K6ltTjTC7o1AYzSnCZtSm3kne2r7dlULsPkCX3WxIzV9OZF7Uc+LX2gU=
X-Google-Smtp-Source: AGHT+IED46H0i7+ooNgDxGsNBK5R2Bs4IMtUVYkHrx0D+KRy4Eo2VtW9NkIdkiwfJMYpasCVhJoidMhTngYiRwwiCA1DqzyHSnoJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4ca9f7d4fc8mr4665173.3.1723469471016; Mon, 12 Aug 2024 06:31:11
 -0700 (PDT)
Date: Mon, 12 Aug 2024 06:31:10 -0700
In-Reply-To: <87ttfpx3z6.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099fa6e061f7c815c@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in skb_trim (2)
From: syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com>
To: toke@toke.dk
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

> syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com> writes:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13eb467d980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=98afa303be379af6cdb2
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/49d96e53e1c4/disk-b446a2da.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/f05350d128a7/vmlinux-b446a2da.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/805c7d86a2db/bzImage-b446a2da.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index 0c7841f95228..f77cb743ca06 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -755,7 +755,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
>                 goto free_skb;
>         default:
>                 skb_reset_tail_pointer(skb);
> -               skb_trim(skb, 0);
> +               __skb_trim(skb, 0);
>  
>                 goto resubmit;
>         }

