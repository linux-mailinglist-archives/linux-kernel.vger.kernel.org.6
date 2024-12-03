Return-Path: <linux-kernel+bounces-430315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E979E2F33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B7B329AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AE41DF977;
	Tue,  3 Dec 2024 22:30:16 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614816DC28
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265015; cv=none; b=XV/FbTzUiAXroqhRzLM76+x5ERWpnQJP8mqvK4ckfxBpsNgc/iaCemxrfatMA6wVozNGWJvTU2Bgn6pRXH9VBUnk8ZMPLtOYt9RwHj7kJ0I38eg+9Tqsv8dRN7EPn88Vr0ckLqmFmbbAU44AxkaqMgwlCRU2DQqbx7aLbAOdKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265015; c=relaxed/simple;
	bh=BbgH2NS+w0yEdRlYqJGcBx/jKI+0Vvjzw4riivYAeMY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q8pKPqzE81eqTlSYW0QzCOi4VUtveBTcc1+8HFJoPdtGlmKK9Vt4cXEjk3vJKtZGCcHs/El5v+J1QZ6hpUyThP57zpRnw/RLxjvg1jmxywUqlhaa6Toviao1T7bMjJS8H9vkzhx9zIV+9x1nWd8IcvTqV+SaQ36pgAP+zybksTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77d56e862so48117245ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 14:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265013; x=1733869813;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=646ZGERFPosedWCXH6z+TWU7u2NKYzyKj0f3ZaoELns=;
        b=LT3gYtP34bpN430X0PTW49u5t7KmrRiZ7scUZp/5M7fLZz3aTGw1sGMMbDgIoAA4hs
         CWjNbdf8qdqCXdUP74CB/se54Gl76ukxBHe1F2O7JINjjz61pmTGXMn9O242bj3zlYe8
         Zd0Zx2c1bNrQkT7EOm5yKa2JxPHl/1kKzQQPW4DsWnL/ZoLIf0cd85tTltL2VZSeMRQB
         +MggQx1Y/zuN3Y8YpBB2tiPy9R7LdyQ0ezwAtYDHB9X22awWuw9rgFbdap/yTkVT+2Po
         ZlWb378pbvCYHCoE0+5Y1aCLUOxrVyu/zGo6JjFZkaJDUaXxgoP90e1YyFvN4NMG6CnK
         SzNA==
X-Gm-Message-State: AOJu0YxB0YVUxIvj/4rPUQw+y9d4J7HS0nLE8WlhP1dI9pGK/SF7fiu8
	OTYZF0JNx48a+c4U7USn+W25T14BW8Vd/78NXYq1bsCiuRwKxqg8rpEbxSztxolpTmPZfZPNwEo
	GMyjDPpu3x4Wb/sXkTrIKfE/EeW7mwbyPVKrXZslpSOixK2z44eldERY=
X-Google-Smtp-Source: AGHT+IGvZRRWMvOJsuHd7581wzKezUh324s8wx1n2KnXu7PRRqOUThdcX2RiG/toaW60Nf46rMvBlSdkaa83c7Zx1lPyWZ93eR4D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:3a7:81dd:d0ad with SMTP id
 e9e14a558f8ab-3a7f9a46b5bmr43851655ab.7.1733265012837; Tue, 03 Dec 2024
 14:30:12 -0800 (PST)
Date: Tue, 03 Dec 2024 14:30:12 -0800
In-Reply-To: <000000000000dd84650615800e67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f8674.050a0220.17bd51.0053.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping
 function called from invalid context
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called f=
rom invalid context
Author: luiz.dentz@gmail.com

#syz test

On Tue, Dec 3, 2024 at 4:15=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
> like the bellow:
>
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:585
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworke=
r/u9:2
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by kworker/u9:2/5070:
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_on=
e_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_sc=
heduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_co=
mplete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:298 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:750 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_=
complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g48=
0e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
>  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:693=
9
>  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
>  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
>  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
>
> Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2fb0835e0c9cefc34614
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
>  net/bluetooth/hci_core.c         |  9 ++--
>  2 files changed, 65 insertions(+), 33 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index ea798f07c5a2..95f11f04e24a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -804,7 +804,6 @@ struct hci_conn_params {
>  extern struct list_head hci_dev_list;
>  extern struct list_head hci_cb_list;
>  extern rwlock_t hci_dev_list_lock;
> -extern struct mutex hci_cb_list_lock;
>
>  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev=
_flags)
>  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->d=
ev_flags)
> @@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_con=
n *conn, __u8 status)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->connect_cfm)
> -                       cb->connect_cfm(conn, status);
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +               if (cb->connect_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.connect_cfm(conn, status);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->connect_cfm_cb)
>                 conn->connect_cfm_cb(conn, status);
> @@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_con=
n *conn, __u8 reason)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->disconn_cfm)
> -                       cb->disconn_cfm(conn, reason);
> +               if (cb->disconn_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.disconn_cfm(conn, reason);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->disconn_cfm_cb)
>                 conn->disconn_cfm_cb(conn, reason);
> @@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn *=
conn, __u8 status)
>
>         encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x0=
0;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->security_cfm)
> -                       cb->security_cfm(conn, status, encrypt);
> +               if (cb->security_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.security_cfm(conn, status, encrypt);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->security_cfm_cb)
>                 conn->security_cfm_cb(conn, status);
> @@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>                         conn->sec_level =3D conn->pending_sec_level;
>         }
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->security_cfm)
> -                       cb->security_cfm(conn, status, encrypt);
> +               if (cb->security_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.security_cfm(conn, status, encrypt);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->security_cfm_cb)
>                 conn->security_cfm_cb(conn, status);
> @@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hci_=
conn *conn, __u8 status)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->key_change_cfm)
> -                       cb->key_change_cfm(conn, status);
> +               if (cb->key_change_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.key_change_cfm(conn, status);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>  }
>
>  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 statu=
s,
> @@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct hci=
_conn *conn, __u8 status,
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->role_switch_cfm)
> -                       cb->role_switch_cfm(conn, status, role);
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +               if (cb->role_switch_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.role_switch_cfm(conn, status, role);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>  }
>
>  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f9e19f9cb5a3..25d180d225c1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_add_tail(&cb->list, &hci_cb_list);
> -       mutex_unlock(&hci_cb_list_lock);
> +       list_add_tail_rcu(&cb->list, &hci_cb_list);
>
>         return 0;
>  }
> @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_del(&cb->list);
> -       mutex_unlock(&hci_cb_list_lock);
> +       list_del_rcu(&cb->list);
> +       synchronize_rcu();
>
>         return 0;
>  }
> --
> 2.47.1
>


--=20
Luiz Augusto von Dentz

