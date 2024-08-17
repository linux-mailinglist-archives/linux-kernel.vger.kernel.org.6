Return-Path: <linux-kernel+bounces-290764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC9F955856
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FB1282C73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247A1547F2;
	Sat, 17 Aug 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki/w9fTr"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0136146596;
	Sat, 17 Aug 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904676; cv=none; b=t0R5HY/uzsf2tkJ7P/GyAmF8PUVtyyjPBJS+tpGWOAq3R4BUqnKlLYpkPzGoRPxwcTZRy3Jf9nUW8Fw1Cc25TFJnTei29B4TMWoWgoWA+Q0RuuqOf5VuHwngs3yRPBZtLUEEH1Y6p+J6pzLKbWBOVjI2oYsYlzFciNiyjJ8XHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904676; c=relaxed/simple;
	bh=V36+5U+Rf6AlMUR5aRKGPesWGPSbPaMZ5KL23zwiIKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpMYuOqv14SGiRpgQ/wfG4aJEn0Lazk7EIxyPuUtg2tFgcCKuswFSBLIK/7BM/p4zYJOTWOR8rSmiviHwjqkuRNA/UId8EIw/bEixlUYNdEBym02P7Z+mQHlA/wAAqAJ1qOqdvTYl8VdI62BpfMEXix2vOjPDQPQdOOnNyvuEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki/w9fTr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3717de33d58so1702847f8f.1;
        Sat, 17 Aug 2024 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723904673; x=1724509473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2ylZGda1UbKFev/Hg4IvXMUgiJFczD/6TSHLJ0QRZU=;
        b=ki/w9fTrV99b4UlLrDceDo7zbpr2JkGs8MzVkoi1wXrJFAUNrMB5xLdqDNKVl9nFVU
         FQkkLZzShQ4P8aFYSdtYsjEKTJ6DWlenj9gj82bZkmmBAT80BYfmMT6YKbDs/R8loYqA
         ZTFqJSW3daNSN4kzbkHZEOBeRJ2E0qU+r41RWjENY1+qTl4xA8hJfEBI7eEEgj/cxZyo
         xYt70b6gBF08G1O1Uq75CYGqDw+w2hs0mWfToxFnAAhEZ/p1w58fHXgYugTCWPket3aM
         sy2TAvNeSWajiV93LFJ+l1SoTHGNo6OByGf2KToKvUfyt9VSGZL5o8H6+C6JfpAf/TrP
         OuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723904673; x=1724509473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2ylZGda1UbKFev/Hg4IvXMUgiJFczD/6TSHLJ0QRZU=;
        b=kdGuyZGxX0g0+GwtCs2IHKY6AE15PNSTi+gUoEgA8RXg+7etIWfXwGJBCqbl48BlE2
         SktV22C/uVJybxvcbRNIPw7ky5kK2b+k8bB/MDmzfgz8Ezq+YOqzAliXS1+wrOF+NrPO
         oLv/7H47eefJIUkz7jhm27rwYSE/+u7WAoGAGfFI6+ER04/tGkm6ru7Ap5U7ufdDGeCp
         BeFO/tPw7rvK/pC0WBMQn/uhe8EuvnHcNwh7iAtgpraJVrJicRfF1fx3tb0BmlAJHulw
         rpFHTyiEMSH2MJ60e//7Kw5/BaWLMVRcPc6ETWQ8gaJHs6wZQs5a6bLYQmIVxcLU9bCd
         AvEA==
X-Forwarded-Encrypted: i=1; AJvYcCWlzpRQBGqFd4t36ru8R1M/Y5+759zKHP4+EjXZbgGyaworjGuV5m0VCCgujBu56e+qFZnUYA6zpXMBSA7d/FofE0T9wQncW/tLa7qoFgSI7mW7E7XyMajrgjlnIzfSzg0zcLI4kYO+
X-Gm-Message-State: AOJu0YyjTrfAKl071wiXjWeUWU/iKKLjsubVwCYMtqk2FsW7OzDadHcF
	8OtOLZ59KEovEgJjwo/x8r3ho9Ue4Dbj1pO7OWpCLWpkhyzvf+SLKGV9ELwgxkMJ4K/YKJgwbRg
	FRgoI4lP1yWuzjCvXEqslr6zfH4s=
X-Google-Smtp-Source: AGHT+IF7RwnVwpW0z165xK7DTXOlfNsz1aeKMZU3huOOoqNGMVoAt+/OBTyKpWWj89IGnwJkhUhihXY3NCtj49gxpvA=
X-Received: by 2002:adf:e907:0:b0:371:8ae3:2941 with SMTP id
 ffacd0b85a97d-371946a44d3mr3306154f8f.58.1723904672745; Sat, 17 Aug 2024
 07:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814125525.3917130-2-crwulff@gmail.com> <294f091e-aa0c-4f1d-b827-db3339a0a8af@stanley.mountain>
In-Reply-To: <294f091e-aa0c-4f1d-b827-db3339a0a8af@stanley.mountain>
From: Chris Wulff <crwulff@gmail.com>
Date: Sat, 17 Aug 2024 10:24:21 -0400
Message-ID: <CAB0kiBKeBwHNm1B7RCYTK1KTUrWS4=NzTdLRV6sdDH1wqCFJHQ@mail.gmail.com>
Subject: Re: [PATCH v4] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, linux-usb@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konstantin Aladyshev <aladyshev22@gmail.com>, 
	David Sands <david.sands@biamp.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-kernel@vger.kernel.org, 
	Chris Wulff <Chris.Wulff@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 2:49=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/crwulff-gmail-com/=
USB-gadget-f_hid-Add-GET_REPORT-via-userspace-IOCTL/20240814-225520
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git us=
b-testing
> patch link:    https://lore.kernel.org/r/20240814125525.3917130-2-crwulff=
%40gmail.com
> patch subject: [PATCH v4] USB: gadget: f_hid: Add GET_REPORT via userspac=
e IOCTL
> config: x86_64-randconfig-161-20240817 (https://download.01.org/0day-ci/a=
rchive/20240817/202408171146.0RjWnTq8-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a=
15a9eac96088ae5e9134248d8236e34b91b1)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202408171146.0RjWnTq8-lkp@intel.com/
>
> smatch warnings:
> drivers/usb/gadget/function/f_hid.c:705 f_hidg_get_report() warn: inconsi=
stent returns '&hidg->get_report_spinlock'.
> drivers/usb/gadget/function/f_hid.c:705 f_hidg_get_report() warn: inconsi=
stent returns 'flags'.
>
> vim +705 drivers/usb/gadget/function/f_hid.c
>
> fce51fb916013b Chris Wulff 2024-08-14  653  static int f_hidg_get_report(=
struct file *file, struct usb_hidg_report __user *buffer)
> fce51fb916013b Chris Wulff 2024-08-14  654  {
> fce51fb916013b Chris Wulff 2024-08-14  655      struct f_hidg            =
       *hidg =3D file->private_data;
> fce51fb916013b Chris Wulff 2024-08-14  656      struct usb_composite_dev =
       *cdev =3D hidg->func.config->cdev;
> fce51fb916013b Chris Wulff 2024-08-14  657      unsigned long   flags;
> fce51fb916013b Chris Wulff 2024-08-14  658      struct report_entry *entr=
y;
> fce51fb916013b Chris Wulff 2024-08-14  659      struct report_entry *ptr;
> fce51fb916013b Chris Wulff 2024-08-14  660      __u8 report_id;
> fce51fb916013b Chris Wulff 2024-08-14  661
> fce51fb916013b Chris Wulff 2024-08-14  662      entry =3D kmalloc(sizeof(=
*entry), GFP_KERNEL);
> fce51fb916013b Chris Wulff 2024-08-14  663      if (!entry)
> fce51fb916013b Chris Wulff 2024-08-14  664              return -ENOMEM;
> fce51fb916013b Chris Wulff 2024-08-14  665
> fce51fb916013b Chris Wulff 2024-08-14  666      if (copy_from_user(&entry=
->report_data, buffer,
> fce51fb916013b Chris Wulff 2024-08-14  667                              s=
izeof(struct usb_hidg_report))) {
> fce51fb916013b Chris Wulff 2024-08-14  668              ERROR(cdev, "copy=
_from_user error\n");
> fce51fb916013b Chris Wulff 2024-08-14  669              kfree(entry);
> fce51fb916013b Chris Wulff 2024-08-14  670              return -EINVAL;
> fce51fb916013b Chris Wulff 2024-08-14  671      }
> fce51fb916013b Chris Wulff 2024-08-14  672
> fce51fb916013b Chris Wulff 2024-08-14  673      report_id =3D entry->repo=
rt_data.report_id;
> fce51fb916013b Chris Wulff 2024-08-14  674
> fce51fb916013b Chris Wulff 2024-08-14  675      spin_lock_irqsave(&hidg->=
get_report_spinlock, flags);
> fce51fb916013b Chris Wulff 2024-08-14  676      ptr =3D f_hidg_search_for=
_report(hidg, report_id);
> fce51fb916013b Chris Wulff 2024-08-14  677
> fce51fb916013b Chris Wulff 2024-08-14  678      if (ptr) {
> fce51fb916013b Chris Wulff 2024-08-14  679              /* Report already=
 exists in list - update it */
> fce51fb916013b Chris Wulff 2024-08-14  680              if (copy_from_use=
r(&ptr->report_data, buffer,
> fce51fb916013b Chris Wulff 2024-08-14  681                              s=
izeof(struct usb_hidg_report))) {
> fce51fb916013b Chris Wulff 2024-08-14  682                      ERROR(cde=
v, "copy_from_user error\n");
> fce51fb916013b Chris Wulff 2024-08-14  683                      kfree(ent=
ry);
> fce51fb916013b Chris Wulff 2024-08-14  684                      return -E=
INVAL;
>
> spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);

This does appear to be legitimate. I will make sure the spinlock is
released on that error path and post a new version.

>
> fce51fb916013b Chris Wulff 2024-08-14  685              }
> fce51fb916013b Chris Wulff 2024-08-14  686              kfree(entry);
> fce51fb916013b Chris Wulff 2024-08-14  687      } else {
> fce51fb916013b Chris Wulff 2024-08-14  688              /* Report does no=
t exist in list - add it */
> fce51fb916013b Chris Wulff 2024-08-14  689              list_add_tail(&en=
try->node, &hidg->report_list);
> fce51fb916013b Chris Wulff 2024-08-14  690      }
> fce51fb916013b Chris Wulff 2024-08-14  691
> fce51fb916013b Chris Wulff 2024-08-14  692      /* If there is no respons=
e pending then do nothing further */
> fce51fb916013b Chris Wulff 2024-08-14  693      if (hidg->get_report_retu=
rned) {
> fce51fb916013b Chris Wulff 2024-08-14  694              spin_unlock_irqre=
store(&hidg->get_report_spinlock, flags);
> fce51fb916013b Chris Wulff 2024-08-14  695              return 0;
> fce51fb916013b Chris Wulff 2024-08-14  696      }
> fce51fb916013b Chris Wulff 2024-08-14  697
> fce51fb916013b Chris Wulff 2024-08-14  698      /* If this userspace resp=
onse serves the current pending report */
> fce51fb916013b Chris Wulff 2024-08-14  699      if (hidg->get_report_req_=
report_id =3D=3D report_id) {
> fce51fb916013b Chris Wulff 2024-08-14  700              hidg->get_report_=
returned =3D true;
> fce51fb916013b Chris Wulff 2024-08-14  701              wake_up(&hidg->ge=
t_queue);
> fce51fb916013b Chris Wulff 2024-08-14  702      }
> fce51fb916013b Chris Wulff 2024-08-14  703
> fce51fb916013b Chris Wulff 2024-08-14  704      spin_unlock_irqrestore(&h=
idg->get_report_spinlock, flags);
> fce51fb916013b Chris Wulff 2024-08-14 @705      return 0;
> fce51fb916013b Chris Wulff 2024-08-14  706  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

