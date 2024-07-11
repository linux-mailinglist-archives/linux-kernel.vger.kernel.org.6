Return-Path: <linux-kernel+bounces-249403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C792EB40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37278282AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468CF16A934;
	Thu, 11 Jul 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL6K2gR7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF31E531
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710270; cv=none; b=SrWLAMyJreZnNxzK9jFbo8EMzjiNLMifNN4o9AIwdiskmcPpvNE0YcImq2Xtd/t9rjRtnZLymBWAQU0h1cAlDUVN9v8WkO1gWSdIO0CUgEaER6cnzqdVXARsANMToE+fvPpqyhRP+6LphDOlgeB8REp7IlCMd80sWYe0Szs/VH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710270; c=relaxed/simple;
	bh=RIhfOzVcXIy7+AwNsdNPGSuaq68Hqj9Gr8kJENzAlEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrZgdxdCmMU2dgYgBwkfM6dFtjI8ow1eFkYK+t8aCxynPzYdkcjRH7g10aan5WmexddzIs1mA75Lk/rJ5kzLGtFa0XQNSQmgQOYJjTAflSZa1zxIgIWt4gWjsBNRETu6TTqBA3c8m74EpTbG2pLtNUAv8Ci50MEBVkzR6SvPZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL6K2gR7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
	b=FL6K2gR7hCqqx6YFPGfH4B6wtsqOD0owQYaGN8hdWOb6VHRJsfN9BWe65QQc00IpcUK9G/
	xqB+Gv/BscE0h9O+vGatv0X2AmDJG0SSjdSXRtyjFJ9Dbqleui4x8e0wqOBir1q9k2uWts
	F1AgXF2Wnwudxf5AnH4YWv6/OWVlm2g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-XMGgVrKZMS2rJfb8ZQ69gw-1; Thu, 11 Jul 2024 11:04:18 -0400
X-MC-Unique: XMGgVrKZMS2rJfb8ZQ69gw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e994d8e26so1002327e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710257; x=1721315057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
        b=RE8XdZ2aMk3mKKtYdIKLKi++q1+j3o6Uyym99JgMprGf9R4Sh8gjru5NIgGTdNpvnj
         kS/mN1K1ukSitauc8VkqpyvHb98Zcm+/2aCfYpfrZ0QUial6oewvSJF0Xyt2uSrEe77X
         iDhu1DG/uw6ManFQ1xlYZMqLu/wLEBaUzAzP1Q1qLlALlQZ+ZqpdOeXgbWbfC6UZDfBx
         189o2KOVmK8nZ+QuoTv5JCAMEnCbM+preup1PF0uhriyyebR/JylSmmlV5Eyxiffa+vj
         O/PnV0J/xYhywVn5hZtAQw5dQ7hMUNXcT1MYUFgwl9kU1OHmgvg2Coh3qfrP9AFiUDhk
         kBpQ==
X-Gm-Message-State: AOJu0Yy8UGYxRK8ycyQVWUFm4BcClInoVd4u73ZH4ONNUJRqKl3931tp
	gSbxoIJtc9MiXxADhDTD1lb6eNEf/Ys1QzSfBHpgacf/v01iOrdpqHqk7EDlGUcWgPne8NpD4Pk
	09LbvPfW6CBHuYsde9i1YDWE+U3UviPm8zcPupPYXLRIp8PckD9aaYsjtzsp2Rw==
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550989e87.65.1720710256760;
        Thu, 11 Jul 2024 08:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZslfRADh61h2K4U2I0v8TWlsmuDejSX07DbIntDk5o01Hp5GIPBHFAcNOq0qN0Q3YbDMbqA==
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550931e87.65.1720710255957;
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74462esm118919565e9.48.2024.07.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Message-ID: <90f0cdd6-379f-49a0-9bb2-ba86c3e8ccce@redhat.com>
Date: Thu, 11 Jul 2024 17:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
 <20240711143425.GA1235314@perftesting>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240711143425.GA1235314@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 16:34, Josef Bacik wrote:
> On Thu, Jul 11, 2024 at 10:21:35AM +0200, Hanna Czenczek wrote:
>> On 10.07.24 20:42, Josef Bacik wrote:
>>> On Wed, Jul 10, 2024 at 09:28:08AM +0200, Hanna Czenczek wrote:
>>>> On 09.07.24 19:56, Josef Bacik wrote:
>>>>> On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We want to be able to mount filesystems that just consist of one regular
>>>>>> file via virtio-fs, i.e. no root directory, just a file as the root
>>>>>> node.
>>>>>>
>>>>>> While that is possible via FUSE itself (through the 'rootmode' mount
>>>>>> option, which is automatically set by the fusermount help program to
>>>>>> match the mount point's inode mode), there is no virtio-fs option yet
>>>>>> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>>>>>>
>>>>>> To do that, this series introduces a new 'file' mount option that does
>>>>>> precisely that.  Alternatively, we could provide the same 'rootmode'
>>>>>> option that FUSE has, but as laid out in patch 1's commit description,
>>>>>> that option is a bit cumbersome for virtio-fs (in a way that it is not
>>>>>> for FUSE), and its usefulness as a more general option is limited.
>>>>>>
>>>>> All this does is make file an alias for something a little easier for users to
>>>>> read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
>>>>> 'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
>>>>> necessary to do this in the kernel.  Thanks,
>>>> This series is not about normal FUSE filesystems (file_system_type
>>>> fuse_fs_type, “fuse”), but about virtio-fs (file_system_type virtio_fs_type,
>>>> “virtiofs”), i.e. a case where libfuse and fusermount are not involved at
>>>> all.  As far as I’m aware, mounting a virtio-fs filesystem with a
>>>> non-directory root inode is currently not possible at all.
>>> Ok so I think I had it backwards in my head, my apologies.
>>>
>>> That being said I still don't understand why this requires a change to virtiofs
>>> at all.
>>>
>>> I have a virtiofs thing attached to my VM.  Inside the vm I do
>>>
>>> mount -t virtiofs <name of thing I've attached to the vm> /directory
>>>
>>> and then on the host machine, virtiofsd is a "normal" FUSE driver, except it's
>>> talking over the socket you setup between the guest and the host.  I assume this
>>> is all correct?
>>>
>>> So then the question is, why does it matter what virtiofsd is exposing?  I guess
>>> that's the better question.  The guest shouldn't have to care if it's a
>>> directory or a file right?  The mountpoint is going to be a directory, whatever
>>> is backing it shouldn't matter.  Could you describe the exact thing you're
>>> trying to accomplish?  Thanks,
>> The mount point needs to be of the same mode as the root node of the mounted
>> filesystem, or it’ll be inaccessible after mounting[1].  In this case, I
>> want to export a regular file as the root node, so the root node must be a
>> regular file, too:
>>
>> host$ echo foo > /tmp/bar
>>
>> host$ virtiofsd --shared-dir /tmp/bar --socket-path /tmp/viofsd.sock
>> --sandbox none
>>
>>
>> guest# mkdir /tmp/mnt-dir
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-dir
>>
>> guest# stat /tmp/mnt-dir
>> stat: cannot statx '/tmp/mnt-dir': Input/output error
>>
>> guest# cat /tmp/mnt-dir
>> cat: /tmp/mnt-dir: Input/output error
>>
>> guest# ls /tmp/mnt-dir
>> ls: cannot access '/tmp/mnt-dir': Input/output error
>>
>> guest# umount /tmp/mnt-dir
>>
>> (following with this series applied)
>>
>> guest# touch /tmp/mnt-file
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-file -o file
>>
>> guest# stat /tmp/mnt-file
>>    File: /tmp/mnt-file
>>    Size: 4               Blocks: 8          IO Block: 4096   regular file
>> [...]
>>
>> guest# cat /tmp/mnt-file
>> foo
>>
>> guest# ls --file-type /tmp/mnt-file
>> /tmp/mnt-file
>>
>> guest# ls --file-type /tmp
>> mnt-dir/
>> mnt-file
>> [...]
>>
> Got it, this makes sense, thanks for explaining it to me.  You can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Hanna


