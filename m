Return-Path: <linux-kernel+bounces-331328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E597AB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7778A28199D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828B1292CE;
	Tue, 17 Sep 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTAYCN1g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476793A8F7;
	Tue, 17 Sep 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554196; cv=none; b=sIdIX3jRWQqwcd7QfiXQCTZTMhe1Dq1BT8xv+Akbpxh41bfnDq6Hr8ROic+xqIGG0hfdR4Go6eAPygmDqAuTYozGzTDQnd0LJo4Yt4u+IC8eIWT8UYcpnHwQgONzyhFkUzwJI2Sp+S412hlqbBsym2eomiy/JWeqL/uQcEzRANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554196; c=relaxed/simple;
	bh=MHZ6TBzV7dK+73H4yIqXBlCwEmhZLW3I8Ye/passFWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLKFF7PmhghXS5T4myVeNdjvAtAMK/rZ3pE6zrK3Hv9jds+cOl28ewwAxydJB7S1193mQBE/sivY9EMleB8u6x23pqLD+SrkVCTKxHVsyGE35vZQNsQwMNhoYfEe/wH5woN+Ef7wKCLY2At5yOzCA9/ejWiLYkT5H/Ta+bqGqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTAYCN1g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2055a3f80a4so35018985ad.2;
        Mon, 16 Sep 2024 23:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726554194; x=1727158994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lssmupy31DP9vTEmMY66pZzEecZJ03hgiUUD1EIaisY=;
        b=XTAYCN1gxFVRAvIcxuLY9udLfmoK+qwoqrADL/952dowMAqhxsY+S5AUwPtOB9qFDv
         bYJ2wbXegweSfu7TJuf8u3xmUxrqDqVV23UpJHpBBy+a1xVlcWadzcrWNXg9B+KgLzZC
         vQC2O1+zNK4ciVugplejSpr82D+iQYQTDw8XUZXiWrqHwplZO8qdzvUi9MhQNNlKBDea
         erYFik9V4rXlO41RRErEwOA6/jT6Fm+0yd2M+whcVGs5fMSqmeVFKJuv8CIYHYwEHevj
         YsRh2upHVFE/biWxsFtOq+zDCJg1DJtNs3G7Wg9Rq2jTWjrbrORHh0J7ds94Pe5zkvTY
         ohEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726554194; x=1727158994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lssmupy31DP9vTEmMY66pZzEecZJ03hgiUUD1EIaisY=;
        b=k5JZJ+zyuWk67BaILMUMJFBNG0GYZtc56CtPLDDKQINDTkkzIkoVbyjoSbcMxtgSbk
         blnXhpX5rwWX1S4Mtfx58pT2lOzSCmA0BYKRz6/mUDValMGtWPI9bo6mUr5PhPLu96ck
         5rqGQ4iQSgIRvB2eJutNz3hf+hCWdXFMUc7t+GfXJsFSVZC6Qg39N4DxM00t+2CsNvMJ
         1DQ3K3d5gV08cx/IpZI5p9aOqjNbEKmH0aNfmeSMov6tuU3Asr9yaZUOgKmLndJlUnhQ
         UrkqWPLi7Iu6Sy8rvtvPH0vaSun0A3YJbCEzobsUKT9XRJVxwfQ26+Jq1p1sY6cyhDS3
         Myig==
X-Forwarded-Encrypted: i=1; AJvYcCVe3AEacNhY85oeAE2kkF0wg0zNNpIM/R7d/VNQaun2IthaoDb7cHX9T317fA3OquoeeN49b1Mwx2yu@vger.kernel.org, AJvYcCWRqTfaU3nL3uXOvS1tIVmVeJWipkhAmctN+g+M1Zsr4Q4DZHIvj2FrdteTS+9peTlssKiDPyyqfkA64J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UWPtcX2adN1fUe2LuM21mdn7yI5B8Jn8Sy87X8jhaYqWuDN/
	X84K2YcBrVm7MrEG2r9j8NQJ6DC4vZvf9wCdttI5gFzmy4hItNqc3Lo062tx3gbWaz8gsLs9D/O
	ZanjvHm3O9yCy3O66RtVT3bFcaHY=
X-Google-Smtp-Source: AGHT+IGJTHVZdoDO5HJBZmPo9F6gVZnzpPARSZ6LOyRm1uxyS7SUHcSjHLQCMjG2on+hkbBVT4oCZCv6StIehcdqnQQ=
X-Received: by 2002:a17:90a:9e1:b0:2d8:8bfd:d10b with SMTP id
 98e67ed59e1d1-2dba0067ffamr18580562a91.26.1726554194461; Mon, 16 Sep 2024
 23:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916040629.28750-1-aha310510@gmail.com> <2024091648-excusable-unfilled-83de@gregkh>
 <15bc0f3a-5433-43e0-b0b0-8b9c26dec165@suse.com> <CAO9qdTHrbG-aWetpM_e7zHUhrwPD=7uCHPbWSMoorgnwjKEOmA@mail.gmail.com>
 <bf971924-9d91-40a3-a4c2-5b518e2ce2fd@suse.com>
In-Reply-To: <bf971924-9d91-40a3-a4c2-5b518e2ce2fd@suse.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 17 Sep 2024 15:23:02 +0900
Message-ID: <CAO9qdTHWfYv8u-gJqGkuG_OSdkU9c=qZSnEbE+zCYWG5bT6r+Q@mail.gmail.com>
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, colin.i.king@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver Neukum <oneukum@suse.com> wrote:
>
> Hi,
>
> On 16.09.24 14:44, Jeongjun Park wrote:
> > Oliver Neukum <oneukum@suse.com> wrote:
> >>
> >>
> >>
> >> On 16.09.24 06:15, Greg KH wrote:
> >>> On Mon, Sep 16, 2024 at 01:06:29PM +0900, Jeongjun Park wrote:
>
> >>> Please use the guard() form here, it makes the change much simpler and
> >>> easier to review and maintain.
> >>
> >> That would break the O_NONBLOCK case.
> >>
> >> Looking at the code it indeed looks like iowarrior_read() can race
> >> with itself. Strictly speaking it always could happen if a task used
> >> fork() after open(). The driver tries to restrict its usage to one
> >> thread, but I doubt that the logic is functional.
> >>
> >> It seems to me the correct fix is something like this:
> >
> > Well, I don't know why it's necessary to modify it like this.
> > I think it would be more appropriate to patch it to make it
> > more maintainable by using guard() as Greg suggested.
>
> Allow me to explain detail.
>
> guard() internally uses mutex_lock(). That means that
>
> a) it will block
> b) having blocked it will sleep in the state TASK_UNINTERRUPTIBLE
>
> The driver itself uses TASK_INTERRUPTIBLE in iowarrior_read(),
> when it waits for IO. That is entirely correct, as it waits for
> an external device doing an operation that may never occur. You
> must use TASK_INTERRUPTIBLE.
>
> Now, if you use mutex_lock() to wait for a task waiting for IO
> to occur in the state TASK_INTERRUPTIBLE, you are indirectlywaiting for
> an event that you must wait for in TASK_INTERRUPTIBLE in the state
> TASK_UNINTERRUPTIBLE.
> That is a bug. You have created a task that cannot be killed (uid may not match),
> but may have to be killed. Furthermore you block even in case the
> device has been opened with O_NONBLOCK, which is a second bug.
>
> These limitations are inherent in guard(). Therefore you cannot use
> guard here.

Okay. But O_NONBLOCK flag check already exists, and I don't know
if we need to branch separately to mutex_trylock just because O_NONBLOCK
flag exists. I think mutex_lock_interruptible is enough.

And the point of locking is too late. I think it would be more appropriate to
read file->private_data and then lock it right away.

I think this patch is a more appropriate patch:

---
 drivers/usb/misc/iowarrior.c | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..6fb4ecebbc15 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,40 @@ static ssize_t iowarrior_read(struct file *file,
char __user *buffer,
    struct iowarrior *dev;
    int read_idx;
    int offset;
+   int retval = 0;

    dev = file->private_data;

+   if (mutex_lock_interruptible(&dev->mutex)) {
+       retval = -EAGAIN;
+       goto exit;
+   }
+
    /* verify that the device wasn't unplugged */
-   if (!dev || !dev->present)
-       return -ENODEV;
+   if (!dev->present) {
+       retval = -ENODEV;
+       goto unlock_exit;
+   }

    dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
        dev->minor, count);

    /* read count must be packet size (+ time stamp) */
    if ((count != dev->report_size)
-       && (count != (dev->report_size + 1)))
-       return -EINVAL;
+       && (count != (dev->report_size + 1))) {
+       retval = -EINVAL;
+       goto unlock_exit;
+   }

    /* repeat until no buffer overrun in callback handler occur */
    do {
        atomic_set(&dev->overflow_flag, 0);
        if ((read_idx = read_index(dev)) == -1) {
            /* queue empty */
-           if (file->f_flags & O_NONBLOCK)
-               return -EAGAIN;
+           if (file->f_flags & O_NONBLOCK) {
+               retval = -EAGAIN;
+               goto unlock_exit;
+           }
            else {
                //next line will return when there is either new data,
or the device is unplugged
                int r = wait_event_interruptible(dev->read_wait,
@@ -309,28 +321,37 @@ static ssize_t iowarrior_read(struct file *file,
char __user *buffer,
                                  -1));
                if (r) {
                    //we were interrupted by a signal
-                   return -ERESTART;
+                   retval = -ERESTART;
+                   goto unlock_exit;
                }
                if (!dev->present) {
                    //The device was unplugged
-                   return -ENODEV;
+                   retval = -ENODEV;
+                   goto unlock_exit;
                }
                if (read_idx == -1) {
                    // Can this happen ???
-                   return 0;
+                   goto unlock_exit;
                }
            }
        }

        offset = read_idx * (dev->report_size + 1);
        if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-           return -EFAULT;
+           retval = -EFAULT;
+           goto unlock_exit;
        }
    } while (atomic_read(&dev->overflow_flag));

    read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
    atomic_set(&dev->read_idx, read_idx);
+   mutex_unlock(&dev->mutex);
    return count;
+
+unlock_exit:
+   mutex_unlock(&dev->mutex);
+exit:
+   return retval;
 }

 /*
--

>
>         Regards
>                 Oliver

